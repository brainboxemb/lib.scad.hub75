#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

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
