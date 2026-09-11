# Verification

`test/` and `vrf/` deliberately answer different questions.

- `test/` checks software/API regression: does the library still return and build
  what its source currently specifies?
- `vrf/` checks correspondence with reality: does that specification agree with
  measured HUB75 hardware, and can a consumer build useful mating/measurement
  geometry from the public API?

## Start here

Do **not** start with the full measurement catalogue or the long spacing gauges.
The first physical procedure is Stage 1 in
[`physical-panel-validation.md`](physical-panel-validation.md): the **upper-left
corner viewed from the rear**.

That procedure shows:

- the exact panel area and orientation;
- the physical features being checked;
- the small `TL1 v0.1` profile comb;
- how the comb is positioned;
- which checks use the comb and which still require a caliper/pin/depth method;
- what to record and how to classify a discrepancy.

The printable helpers are documented in
[`fixtures/README.md`](fixtures/README.md).

The compact verification catalogue in
[`measurement-catalog.yml`](measurement-catalog.yml) remains a roadmap/checklist
of model features that still need physical confirmation. It is not itself the
operator procedure and is intentionally not a store for raw measurements or
photographs.

Raw vendor/source material, physical sample measurements and supporting photos
should eventually live in a separate companion data repository. The proposed
repository is `lib.scad.hub75.data`; the library should only retain the small
accepted verification baseline and a provenance link/commit to the data that
justified it.

Functional software verification is currently generated from
`test/hub75_p5_64x32_panel_api.scad`.

Generated STL/images/evidence are written below `vrf/out/` and are not committed
to `main`.
