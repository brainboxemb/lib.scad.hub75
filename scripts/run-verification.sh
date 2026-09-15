#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

EXPECTED_GIT_TOOL_SHA="7c43f37e7b07cfb57638a1d1dad2501de09ba7eb"
EXPECTED_SCAD_TOOL_SHA="5712324ea9e3a7c81ba1b79013f2758f52b219cf"
EXPECTED_SCAD_TOOL_REF="v0.14.2"

# Repository/tooling boundary checks for the Migration 005 consumer model.
if ! grep -Fq 'type: scad' project.yml || ! grep -Fq 'config: project.scad.yml' project.yml; then
  echo "ERROR: project.yml must declare project.scad.yml as the SCAD profile" >&2
  exit 1
fi

if grep -Fq 'name: tool.git-project' project.yml; then
  echo "ERROR: tool.git-project must be pinned directly by the parent gitlink, not managed recursively" >&2
  exit 1
fi

TOOL_REF="$(awk '
  $1 == "-" && $2 == "name:" { in_tool = ($3 == "tool.scad-project"); next }
  in_tool && $1 == "ref:" { print $2; exit }
' project.yml)"
if [[ "$TOOL_REF" != "$EXPECTED_SCAD_TOOL_REF" ]]; then
  echo "ERROR: tool.scad-project must use released ref ${EXPECTED_SCAD_TOOL_REF}; got ${TOOL_REF:-<missing>}" >&2
  exit 1
fi

for path in tools/tool.git-project tools/tool.scad-project; do
  if ! git ls-files --stage -- "$path" | grep -q '^160000 '; then
    echo "ERROR: expected committed direct gitlink is missing: $path" >&2
    exit 1
  fi
done

GIT_TOOL_SHA="$(git -C tools/tool.git-project rev-parse HEAD)"
TOOL_SHA="$(git -C tools/tool.scad-project rev-parse HEAD)"
if [[ "$GIT_TOOL_SHA" != "$EXPECTED_GIT_TOOL_SHA" ]]; then
  echo "ERROR: tool.git-project must resolve to ${EXPECTED_GIT_TOOL_SHA}; got ${GIT_TOOL_SHA}" >&2
  exit 1
fi
if [[ "$TOOL_SHA" != "$EXPECTED_SCAD_TOOL_SHA" ]]; then
  echo "ERROR: tool.scad-project must resolve to released ${EXPECTED_SCAD_TOOL_REF} commit ${EXPECTED_SCAD_TOOL_SHA}; got ${TOOL_SHA}" >&2
  exit 1
fi

if [[ -e .github/workflows/design-build.yml || -e .github/workflows/build.yml || -e .github/workflows/verify.yml ]]; then
  echo "ERROR: standalone Build/Verify callers must not coexist with the shared production lifecycle" >&2
  exit 1
fi

SCAD_WORKFLOW=.github/workflows/scad.yml
REUSABLE_PRODUCTION="brainboxemb/tool.scad-project/.github/workflows/project-production.yml@${EXPECTED_SCAD_TOOL_SHA}"
for required in \
  "$REUSABLE_PRODUCTION" \
  'cache_namespace: lib-scad-hub75-production-v2'; do
  if ! grep -Fq "$required" "$SCAD_WORKFLOW"; then
    echo "ERROR: ${SCAD_WORKFLOW} is missing Migration-005 production caller contract: ${required}" >&2
    exit 1
  fi
done
for removed in \
  'affected_task:' \
  'aggregate_task:' \
  'scad.production-impact' \
  'scad.ci' \
  'build_artifact_name:' \
  'verification_artifact_name:'; do
  if grep -Fq "$removed" "$SCAD_WORKFLOW"; then
    echo "ERROR: ${SCAD_WORKFLOW} still exposes removed Migration-004 lifecycle input: ${removed}" >&2
    exit 1
  fi
done

if ! grep -Fq "project-release.yml@${EXPECTED_SCAD_TOOL_SHA}" .github/workflows/release.yml; then
  echo "ERROR: release.yml is not pinned to released tool.scad-project ${EXPECTED_SCAD_TOOL_SHA}" >&2
  exit 1
fi
if ! grep -Fq 'reusable-pr-preview-cleanup.yml@v0.2.8' .github/workflows/pr-cleanup.yml; then
  echo "ERROR: pr-cleanup.yml must use released generic cleanup workflow v0.2.8" >&2
  exit 1
fi

if ! grep -Fq "extends: '../../tools/tool.scad-project/moon/tasks/scad.yml'" .moon/tasks/scad.yml; then
  echo "ERROR: .moon/tasks/scad.yml must inherit the pinned shared SCAD task policy" >&2
  exit 1
fi
if grep -Fq 'workspace:' .moon/workspace.yml || grep -Fq 'inheritedTasks:' .moon/workspace.yml; then
  echo "ERROR: project-level inherited-task selection belongs in moon.yml, not .moon/workspace.yml" >&2
  exit 1
fi
for required in \
  'workspace:' \
  'inheritedTasks:' \
  '- scad.docs' \
  '- scad.build' \
  '- scad.verify' \
  'tasks:' \
  'scad.docs:' \
  'scad.build:' \
  'scad.verify:'; do
  if ! grep -Fq -- "$required" moon.yml; then
    echo "ERROR: moon.yml is missing Migration-005 capability contract: ${required}" >&2
    exit 1
  fi
done

for removed in \
  'scad.build-index:' \
  'scad.build-provenance:' \
  'scad.verification-provenance:' \
  'scad.production-impact:' \
  'scad.ci:' \
  'command:' \
  'script:' \
  'tools/tool.scad-project/**' \
  'tools/tool.git-project/**'; do
  if grep -Fq "$removed" moon.yml; then
    echo "ERROR: moon.yml still contains removed/copied shared lifecycle detail: ${removed}" >&2
    exit 1
  fi
done

if ! grep -Fq 'engine: scons' project.scad.yml; then
  echo "ERROR: lib.scad.hub75 must retain the SCons build engine for the focused-runtime/SCons canary" >&2
  exit 1
fi
if grep -Fq 'pythonscad:' project.scad.yml; then
  echo "ERROR: lib.scad.hub75 must remain OpenSCAD-only so the focused runtime is selected" >&2
  exit 1
fi

if ! cmp -s bootstrap.sh tools/tool.git-project/bootstrap/consumer-bootstrap.sh; then
  echo "ERROR: bootstrap.sh differs from the pinned tool.git-project consumer bootstrap" >&2
  exit 1
fi
if ! cmp -s bootstrap.ps1 tools/tool.git-project/bootstrap/consumer-bootstrap.ps1; then
  echo "ERROR: bootstrap.ps1 differs from the pinned tool.git-project consumer bootstrap" >&2
  exit 1
fi
if ! cmp -s update-repo.sh tools/tool.scad-project/bootstrap/consumer-update.sh; then
  echo "ERROR: update-repo.sh differs from the released tool.scad-project SCAD update wrapper" >&2
  exit 1
fi
if ! cmp -s update-repo.ps1 tools/tool.scad-project/bootstrap/consumer-update.ps1; then
  echo "ERROR: update-repo.ps1 differs from the released tool.scad-project SCAD update wrapper" >&2
  exit 1
fi

echo "Migration 005 HUB75 repository/tooling ownership: OK"

mkdir -p vrf/out/fixtures vrf/out/plan

# OpenSCAD may exit successfully while emitting a completely unusable model after
# an unknown function/undef propagation. Treat those warnings as verification
# failures; ordinary camera notices remain allowed.
run_openscad_checked() {
  local log
  log="$(mktemp)"

  if ! "$@" 2>"$log"; then
    cat "$log" >&2
    rm -f "$log"
    return 1
  fi

  cat "$log" >&2

  if grep -Eq \
    'WARNING: (Ignoring unknown (function|module)|undefined operation|Unable to convert|.*parameter could not be converted|Object may not be a valid 2-manifold)' \
    "$log"; then
    echo "verification: fatal OpenSCAD warning detected" >&2
    rm -f "$log"
    return 1
  fi

  rm -f "$log"
}

render_stl() {
  local output="$1"
  local source="$2"

  run_openscad_checked \
    xvfb-run -a openscad \
      --enable=object-function \
      -o "$output" \
      "$source"
}

# Auto-fitted preview for a standalone fixture. These sources intentionally do
# not define a documentary camera; fitting the complete helper is desirable.
render_png_autofit() {
  local output="$1"
  local source="$2"
  local image_size="$3"

  run_openscad_checked \
    xvfb-run -a openscad \
      --enable=object-function \
      --render \
      --projection=o \
      --autocenter \
      --viewall \
      --imgsize="$image_size" \
      -o "$output" \
      "$source"
}

# Operator-plan views define $vpr/$vpt/$vpd in their .scad adapters. Do not add
# --autocenter/--viewall here: those CLI flags replace the carefully selected
# local framing and can make a close-up blank or shrink it to a dot.
render_png_camera() {
  local output="$1"
  local source="$2"
  local image_size="$3"

  run_openscad_checked \
    xvfb-run -a openscad \
      --enable=object-function \
      --render \
      --projection=o \
      --imgsize="$image_size" \
      -o "$output" \
      "$source"
}

render_stl \
  vrf/out/hub75-p5-64x32-panel-api.stl \
  test/hub75_p5_64x32_panel_api.scad

# First operator procedure: one recognizable top-left rear corner.
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-profile-comb.stl \
  vrf/fixtures/export/top-left-profile-comb.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-top-left-profile-comb.png \
  vrf/fixtures/export/top-left-profile-comb.scad \
  900,500

render_png_camera \
  vrf/out/plan/top-left-location.png \
  vrf/top-left/render/top-left-location.scad \
  520,900
render_png_camera \
  vrf/out/plan/top-left-feature-map.png \
  vrf/top-left/render/top-left-feature-map.scad \
  720,720
render_png_camera \
  vrf/out/plan/top-left-comb-use.png \
  vrf/top-left/render/top-left-comb-use.scad \
  900,620
render_png_camera \
  vrf/out/plan/top-left-comb-side.png \
  vrf/top-left/render/top-left-comb-side.scad \
  900,500

# Secondary helpers retained for later stages of the plan.
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-corner-datum-gauge.stl \
  vrf/fixtures/export/corner-datum-gauge.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-corner-datum-gauge.png \
  vrf/fixtures/export/corner-datum-gauge.scad \
  700,700

render_stl \
  vrf/out/fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.stl \
  vrf/fixtures/export/mounting-spacing-x-gauge.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.png \
  vrf/fixtures/export/mounting-spacing-x-gauge.scad \
  1200,360

render_stl \
  vrf/out/fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.stl \
  vrf/fixtures/export/mounting-spacing-z-gauge.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.png \
  vrf/fixtures/export/mounting-spacing-z-gauge.scad \
  1200,360
