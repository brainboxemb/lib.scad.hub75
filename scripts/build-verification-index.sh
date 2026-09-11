#!/usr/bin/env bash
set -euo pipefail

mkdir -p vrf/out

cat > vrf/out/README.md <<'EOF'
# HUB75 panel verification

This branch is intended to be usable directly at the workbench. Start with the
local upper-left procedure; do not treat the STL files as self-explanatory.

## Downloads for Stage 1 / 1B

### TL1 v0.2 profile comb

- [combined STL](fixtures/hub75-p5-64x32-top-left-profile-comb.stl)
- [preview](fixtures/hub75-p5-64x32-top-left-profile-comb.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-top-left-profile-comb-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-top-left-profile-comb-markings.stl)

### SQ1 v0.1 square/alignment guide

- [combined STL](fixtures/hub75-p5-64x32-top-left-alignment-guide.stl)
- [preview](fixtures/hub75-p5-64x32-top-left-alignment-guide.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-top-left-alignment-guide-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-top-left-alignment-guide-markings.stl)

### R1 v0.1 bay-radius comparator

- [combined STL](fixtures/hub75-p5-64x32-corner-radius-comparator.stl)
- [preview](fixtures/hub75-p5-64x32-corner-radius-comparator.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-corner-radius-comparator-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-corner-radius-comparator-markings.stl)

### R2 v0.1 outer-corner radius comparator

- [combined STL](fixtures/hub75-p5-64x32-outer-corner-radius-comparator.stl)
- [preview](fixtures/hub75-p5-64x32-outer-corner-radius-comparator.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-outer-corner-radius-comparator-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-outer-corner-radius-comparator-markings.stl)

### Dimensioned reference sheet

- [DXF](drawings/hub75-p5-64x32-top-left-dimensions.dxf)
- [preview](drawings/hub75-p5-64x32-top-left-dimensions.png)

The DXF/PNG are dimensioned illustrations and CAD references. A paper print is
**not** a dimensional gauge because printer/driver scaling is not controlled.

The procedures below are generated from the source verification documents on the
same commit. Image links are rewritten to this verification branch so PR previews
and production verification remain self-contained.

---

EOF

publish_doc() {
  local source="$1"
  sed -E \
    -e 's/^(#{1,5}) /\1# /' \
    -e 's#../../../raw/prod/verification/##g' \
    "$source" \
    >> vrf/out/README.md
}

publish_doc vrf/physical-panel-validation.md

cat >> vrf/out/README.md <<'EOF'

---

EOF

publish_doc vrf/top-left/corner-detail-verification.md

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
