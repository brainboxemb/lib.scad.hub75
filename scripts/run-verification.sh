#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

mkdir -p vrf/out

xvfb-run -a openscad   --enable=object-function   -o vrf/out/hub75-p5-64x32-panel-api.stl   test/hub75_p5_64x32_panel_api.scad
