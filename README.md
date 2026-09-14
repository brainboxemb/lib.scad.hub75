# HUB75 panel verification

This branch is intended to be usable directly at the workbench. Start with one
test case in the language you prefer.

## Test cases

- [SQ-01 — Hold TL1 square with SQ1 (English)](test-cases/sq-01-hold-tl1-square-with-sq1.en.md)
- [SQ-01 — TL1 haaks plaatsen met SQ1 (Nederlands)](test-cases/sq-01-tl1-haaks-plaatsen-met-sq1.nl.md)
- [Test case template / Testcase-sjabloon](test-case-template.md)

Each test case answers one question. Design history, CI status and unrelated
measurements stay outside the test case.

## Downloads for Stage 1 / 1B

### TL1 v0.2 profile comb

- [combined STL](fixtures/hub75-p5-64x32-top-left-profile-comb.stl)
- [preview](fixtures/hub75-p5-64x32-top-left-profile-comb.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-top-left-profile-comb-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-top-left-profile-comb-markings.stl)

### SQ1 v0.2 square/alignment guide

- [combined STL](fixtures/hub75-p5-64x32-top-left-alignment-guide.stl)
- [preview](fixtures/hub75-p5-64x32-top-left-alignment-guide.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-top-left-alignment-guide-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-top-left-alignment-guide-markings.stl)

### R1 v0.1 bay-radius comparator

- [combined STL](fixtures/hub75-p5-64x32-corner-radius-comparator.stl)
- [preview](fixtures/hub75-p5-64x32-corner-radius-comparator.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-corner-radius-comparator-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-corner-radius-comparator-markings.stl)

### R2 v0.3 outer-corner radius comparator

- [combined STL](fixtures/hub75-p5-64x32-outer-corner-radius-comparator.stl)
- [preview](fixtures/hub75-p5-64x32-outer-corner-radius-comparator.png)
- AMS multipart: [base STL](fixtures/hub75-p5-64x32-outer-corner-radius-comparator-base.stl) + [raised markings STL](fixtures/hub75-p5-64x32-outer-corner-radius-comparator-markings.stl)

### Dimensioned reference sheet

- [DXF](drawings/hub75-p5-64x32-top-left-dimensions.dxf)
- [preview](drawings/hub75-p5-64x32-top-left-dimensions.png)

The DXF/PNG are dimensioned illustrations and CAD references. A paper print is
**not** a dimensional gauge because printer/driver scaling is not controlled.

## Later-stage fixture downloads

These helpers remain available, but they are intentionally secondary to the
local corner procedure above.

- [Corner datum gauge STL](fixtures/hub75-p5-64x32-corner-datum-gauge.stl) · [preview](fixtures/hub75-p5-64x32-corner-datum-gauge.png)
- [144 mm X mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.png)
- [152 mm adjacent-row Z mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.png)

Generated verification output belongs on the configured verification branch.

<!-- scad-project-evidence-navigation -->
## Producer execution evidence

These files describe the SCAD producer executions that actually created the retained output.
They remain unchanged when equivalent output is later hydrated from cache.

- [scad-verify execution](evidence/executions/scad-verify/execution.json) — capability, producer source revision, exact owner revision and result.
  - [scad-verify log](evidence/executions/scad-verify/execution.log) — concise human-readable producer summary.

## Domain evidence

Structured SCAD/SCons reports contain the detailed target-level build and cache decisions.
They are richer domain evidence, not alternate producer logs.

- No structured domain reports are present for this output.

## Orchestration/materialization evidence

The publication layer may add `orchestration/materialization.json` for the current source revision/context and `orchestration/moon.log` for Moon's execute/cache/hydrate decision.
After cache hydration, that current materialization revision may intentionally differ from the producer `source_revision` above.

## Publication context

`publication-info.txt` records generated-branch context plus source, tooling and runtime provenance.
Publication/finalization consumes prepared output and must not rewrite producer execution evidence.
