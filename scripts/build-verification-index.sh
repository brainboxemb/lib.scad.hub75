#!/usr/bin/env bash
set -euo pipefail

mkdir -p vrf/out
cat > vrf/out/README.md <<'EOF'
# HUB75 panel verification

Physical verification is organised as operator procedures, not as an unexplained
collection of STL files.

## Start here — upper-left rear corner

The first procedure verifies one recognizable corner before moving to full-panel
spacing checks.

![Upper-left verification area](plan/top-left-location.png)

### Feature map

![Upper-left feature map](plan/top-left-feature-map.png)

### TL1 v0.1 profile comb

- [STL](fixtures/hub75-p5-64x32-top-left-profile-comb.stl)
- [fixture preview](fixtures/hub75-p5-64x32-top-left-profile-comb.png)
- [placed on the model](plan/top-left-comb-use.png)
- [strict side view](plan/top-left-comb-side.png)

TL1 is used perpendicular to the rear face. Its top rail follows the expected
front-to-rear top profile, while the rear blade provides screw-centre,
reinforcement-centre, mounting-plane and screw-protrusion witness references.
The operator instructions and numerical targets live in
`vrf/physical-panel-validation.md` on the source branch.

## Secondary helpers

These remain available for later verification stages, after local corner datums
have been understood.

- [Corner datum gauge STL](fixtures/hub75-p5-64x32-corner-datum-gauge.stl) · [preview](fixtures/hub75-p5-64x32-corner-datum-gauge.png)
- [144 mm X mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.png)
- [152 mm adjacent-row Z mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.png)

Generated verification output belongs on the configured verification branch.
EOF
