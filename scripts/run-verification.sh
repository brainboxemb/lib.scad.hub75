#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

# Repository/tooling boundary checks.
if ! grep -Fq 'type: scad' project.yml || ! grep -Fq 'config: project.scad.yml' project.yml; then
  echo "ERROR: project.yml must declare project.scad.yml as the SCAD profile" >&2
  exit 1
fi

if grep -Fq 'name: tool.git-project' project.yml; then
  echo "ERROR: tool.git-project must be pinned directly by the parent gitlink, not managed recursively" >&2
  exit 1
fi

for path in tools/tool.git-project tools/tool.scad-project; do
  if ! git ls-files --stage -- "$path" | grep -q '^160000 '; then
    echo "ERROR: expected committed direct gitlink is missing: $path" >&2
    exit 1
  fi
done

TOOL_REF="$(awk '
  $1 == "-" && $2 == "name:" { in_tool = ($3 == "tool.scad-project"); next }
  in_tool && $1 == "ref:" { print $2; exit }
' project.yml)"
TOOL_SHA="$(git -C tools/tool.scad-project rev-parse HEAD)"
RESOLVED_REF_SHA="$(git -C tools/tool.scad-project rev-parse "${TOOL_REF}^{commit}" 2>/dev/null || true)"
if [[ -z "$TOOL_REF" || "$RESOLVED_REF_SHA" != "$TOOL_SHA" ]]; then
  echo "ERROR: project.yml tool.scad-project ref and gitlink are not aligned" >&2
  exit 1
fi

for mapping in \
  "design-build.yml:project-build" \
  "verify.yml:project-verify" \
  "release.yml:project-release" \
  "pr-cleanup.yml:project-pr-cleanup"; do
  caller="${mapping%%:*}"
  reusable="${mapping#*:}"
  expected="brainboxemb/tool.scad-project/.github/workflows/${reusable}.yml@${TOOL_SHA}"
  if ! grep -Fq "$expected" ".github/workflows/${caller}"; then
    echo "ERROR: .github/workflows/${caller} is not pinned to exact tooling commit ${TOOL_SHA}" >&2
    exit 1
  fi
done

if ! cmp -s bootstrap.sh tools/tool.git-project/bootstrap/consumer-bootstrap.sh; then
  echo "ERROR: bootstrap.sh differs from the pinned tool.git-project consumer bootstrap" >&2
  exit 1
fi
if ! cmp -s bootstrap.ps1 tools/tool.git-project/bootstrap/consumer-bootstrap.ps1; then
  echo "ERROR: bootstrap.ps1 differs from the pinned tool.git-project consumer bootstrap" >&2
  exit 1
fi
if ! cmp -s update-repo.sh tools/tool.scad-project/bootstrap/consumer-update.sh; then
  echo "ERROR: update-repo.sh differs from the pinned tool.scad-project SCAD update wrapper" >&2
  exit 1
fi
if ! cmp -s update-repo.ps1 tools/tool.scad-project/bootstrap/consumer-update.ps1; then
  echo "ERROR: update-repo.ps1 differs from the pinned tool.scad-project SCAD update wrapper" >&2
  exit 1
fi

echo "Repository bootstrap ownership: OK"

mkdir -p vrf/out/fixtures vrf/out/plan vrf/out/drawings

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

render_dxf() {
  local output="$1"
  local source="$2"

  run_openscad_checked \
    xvfb-run -a openscad \
      --enable=object-function \
      -o "$output" \
      "$source"
}

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

# TL1 v0.2: combined one-colour STL plus aligned AMS base/markings parts.
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-profile-comb.stl \
  vrf/fixtures/export/top-left-profile-comb.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-profile-comb-base.stl \
  vrf/fixtures/export/top-left-profile-comb-base.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-profile-comb-markings.stl \
  vrf/fixtures/export/top-left-profile-comb-markings.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-top-left-profile-comb.png \
  vrf/fixtures/export/top-left-profile-comb.scad \
  900,500

# SQ1 v0.2 square/orientation guide.
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-alignment-guide.stl \
  vrf/fixtures/export/top-left-alignment-guide.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-alignment-guide-base.stl \
  vrf/fixtures/export/top-left-alignment-guide-base.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-top-left-alignment-guide-markings.stl \
  vrf/fixtures/export/top-left-alignment-guide-markings.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-top-left-alignment-guide.png \
  vrf/fixtures/render/top-left-alignment-guide-preview.scad \
  900,500

# R1 v0.1: convex probes for the concave ~R5 bay-opening corner.
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-corner-radius-comparator.stl \
  vrf/fixtures/export/corner-radius-comparator.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-corner-radius-comparator-base.stl \
  vrf/fixtures/export/corner-radius-comparator-base.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-corner-radius-comparator-markings.stl \
  vrf/fixtures/export/corner-radius-comparator-markings.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-corner-radius-comparator.png \
  vrf/fixtures/export/corner-radius-comparator.scad \
  1100,520

# R2 v0.3: concave notches for checking the real external rear-corner radius.
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-outer-corner-radius-comparator.stl \
  vrf/fixtures/export/outer-corner-radius-comparator.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-outer-corner-radius-comparator-base.stl \
  vrf/fixtures/export/outer-corner-radius-comparator-base.scad
render_stl \
  vrf/out/fixtures/hub75-p5-64x32-outer-corner-radius-comparator-markings.stl \
  vrf/fixtures/export/outer-corner-radius-comparator-markings.scad
render_png_autofit \
  vrf/out/fixtures/hub75-p5-64x32-outer-corner-radius-comparator.png \
  vrf/fixtures/export/outer-corner-radius-comparator.scad \
  1100,480

render_png_camera \
  vrf/out/plan/top-left-location.png \
  vrf/top-left/render/top-left-location.scad \
  720,620
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
render_png_camera \
  vrf/out/plan/top-left-comb-square-use.png \
  vrf/top-left/render/top-left-comb-square-use.scad \
  900,620
render_png_camera \
  vrf/out/plan/top-left-radius-reinforcement.png \
  vrf/top-left/render/top-left-radius-reinforcement.scad \
  820,720
render_png_camera \
  vrf/out/plan/top-left-r2-use.png \
  vrf/top-left/render/top-left-r2-use.scad \
  900,720

render_dxf \
  vrf/out/drawings/hub75-p5-64x32-top-left-dimensions.dxf \
  vrf/top-left/drawing/top-left-dimension-sheet.scad
render_png_camera \
  vrf/out/drawings/hub75-p5-64x32-top-left-dimensions.png \
  vrf/top-left/render/top-left-dimension-sheet.scad \
  1600,900

# Secondary helpers retained for later stages.
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
