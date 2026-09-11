#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

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

# SQ1 v0.1 square/orientation guide.
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
  vrf/fixtures/export/top-left-alignment-guide.scad \
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

# R2 v0.1: concave notches for checking whether the current R0 outer rear
# perimeter is actually a small moulded radius on the physical panel.
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
