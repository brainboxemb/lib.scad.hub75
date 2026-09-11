#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

mkdir -p vrf/out/fixtures vrf/out/plan vrf/out/drawings

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

render_dxf() {
  local output="$1"
  local source="$2"

  run_openscad_checked \
    xvfb-run -a openscad \
      --enable=object-function \
      -o "$output" \
      "$source"
}

# Auto-fitted preview for a standalone fixture or 2D reference drawing.
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
# --autocenter/--viewall here: those CLI flags replace the selected local framing.
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

# -----------------------------------------------------------------------------
# Stage 1: upper-left rear corner.
# -----------------------------------------------------------------------------

# TL1 v0.2. Combined STL works as a normal one-colour print; base + markings
# share an origin and can be imported as a multipart AMS object in Bambu Studio.
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

# SQ1 v0.1 keeps the thin comb mechanically square using the straight front-most
# top-edge strip; it is an orientation aid, not a dimensional gauge.
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

# R1 v0.1 brackets the modelled ~R4.99 rear-bay inside radius.
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

# 1:1 reference geometry plus a human-readable preview generated from exactly
# the same OpenSCAD source.
render_dxf \
  vrf/out/drawings/hub75-p5-64x32-top-left-dimensions.dxf \
  vrf/top-left/drawing/top-left-dimension-sheet.scad
render_png_autofit \
  vrf/out/drawings/hub75-p5-64x32-top-left-dimensions.png \
  vrf/top-left/drawing/top-left-dimension-sheet.scad \
  1600,900

# -----------------------------------------------------------------------------
# Secondary helpers retained for later stages.
# -----------------------------------------------------------------------------
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
