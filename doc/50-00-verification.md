# HUB75 library verification

This document defines the repository-level verification strategy and records the
current physical-verification state.

Executable physical procedures, testcases, fixtures and render sources remain
under [`vrf/`](../vrf/README.md).

## Two different questions

### Functional/software verification

Functional checks answer:

> Does the library still return and build what its current source specifies?

Current machine evidence includes:

- `test/hub75_p5_64x32_panel_api.scad` exercising the public object/accessor API and complete panel build;
- `scripts/run-verification.sh` forcing OpenSCAD geometry generation and rejecting fatal warning classes;
- generated verification fixtures/renders as buildable geometry;
- live SCAD production and retained execution/orchestration evidence.

This proves implementation consistency; it does **not** prove real-world dimensions.

### Physical verification

Physical verification answers:

> Does the model agree with measured real HUB75 hardware?

The work is split into small testcases. Each testcase should ask one clear
physical question and record identified sample, exact fixture revisions,
repeatable action, expected model target/source, observation/result and evidence.

A successful printed fit is not automatically dimensional proof.

## Current physical status

At the current source state:

- SQ-01 exists in Dutch and English;
- SQ-01 asks only whether an SQ1 helper can hold TL1 squarely and repeatably at the upper-left rear corner without forcing it;
- SQ-01 is **defined but not physically executed**;
- exploratory TL1 v0.2 / SQ1 v0.2 work existed in closed, unmerged PR #19 and is not accepted main-state fixture geometry;
- the wider measurement catalogue remains a roadmap, not retained physical evidence.

Physical verification must therefore not be described as complete.

## Evidence model

Keep these stages separate:

```text
source / specification value
        ↓
physical sample observation
        ↓
review / interpretation
        ↓
accepted library value
```

Do not copy a model target into an observation field when the feature was not
measured. Do not invent one universal tolerance for molded surfaces, hole
locations, printed-helper fit and small-bore measurements.

Use the established first-pass physical states: `agrees`, `investigate`, or
`not checked`.

## Executable physical material

The current physical workbench material includes:

- [physical-panel-validation.md](../vrf/physical-panel-validation.md) — broader operator procedure;
- [SQ-01 Dutch](../vrf/top-left/test-cases/sq-01-tl1-haaks-plaatsen-met-sq1.nl.md);
- [SQ-01 English](../vrf/top-left/test-cases/sq-01-hold-tl1-square-with-sq1.en.md);
- [test-case-template.md](../vrf/test-case-template.md);
- fixture and verification-render sources under `vrf/fixtures/` and `vrf/top-left/`.

The generated `vrf/out/` tree is publication evidence, not source authority.

## Publication and current automation status

Successful verification snapshots are published under `prod/vrf`; PR
qualification uses the corresponding isolated preview namespace.

The generated snapshot includes a copy of this strategy document so verification
evidence can be reviewed self-contained, while this source file remains the authority.

Do not freeze "CI is green" into this document. For current automation status
inspect the exact live GitHub Actions run and `prod/vrf/publication-info.txt`
for the source revision being reviewed.

## Physical completion

A single corner testcase cannot verify the complete panel. Broader physical
completion requires retained evidence for the relevant envelope, mounting
pattern, rear mating geometry, local features and connector keep-outs, with
discrepancies investigated before accepted nominal values are changed.
