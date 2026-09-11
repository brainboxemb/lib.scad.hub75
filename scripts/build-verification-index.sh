#!/usr/bin/env bash
set -euo pipefail

mkdir -p vrf/out

cat > vrf/out/README.md <<'EOF'
# HUB75 panel verification

This branch is intended to be usable directly at the workbench. Start with the
first physical procedure below; do not treat the STL files as self-explanatory.

## Downloads for Stage 1

- [TL1 v0.1 profile comb STL](fixtures/hub75-p5-64x32-top-left-profile-comb.stl)
- [TL1 fixture preview](fixtures/hub75-p5-64x32-top-left-profile-comb.png)

The procedure below is generated from `vrf/physical-panel-validation.md` on the
same source commit. Image links are rewritten to this verification branch so the
PR preview and production verification page are self-contained.

---

EOF

# Publish the operator procedure itself, not merely a link back to the source
# branch. Shift its headings down one level so this generated page keeps one H1,
# and rewrite production image links so the same document works on isolated PR
# verification branches.
sed -E \
  -e 's/^(#{1,5}) /\1# /' \
  -e 's#../../../raw/prod/verification/##g' \
  vrf/physical-panel-validation.md \
  >> vrf/out/README.md

cat >> vrf/out/README.md <<'EOF'

---

## Later-stage fixture downloads

These helpers remain available, but they are intentionally secondary to the
local corner procedure above.

- [Corner datum gauge STL](fixtures/hub75-p5-64x32-corner-datum-gauge.stl) · [preview](fixtures/hub75-p5-64x32-corner-datum-gauge.png)
- [144 mm X mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.png)
- [152 mm adjacent-row Z mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.png)

Generated verification output belongs on the configured verification branch.
EOF
