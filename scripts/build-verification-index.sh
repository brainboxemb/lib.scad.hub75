#!/usr/bin/env bash
set -euo pipefail

mkdir -p vrf/out
cat > vrf/out/README.md <<'EOF'
# HUB75 panel verification

Functional verification builds the default panel through the public
`hub75_panel_create()` / `hub75_panel_build()` object API and checks key
derived dimensions.

Generated verification output belongs on the `verification` branch.
EOF
