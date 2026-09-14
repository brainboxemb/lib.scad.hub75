# Verification

`test/` and `vrf/` deliberately answer different questions.

- `test/` checks software/API regression: does the library still return and build what its source currently specifies?
- `vrf/` checks correspondence with reality: does that specification agree with measured HUB75 hardware, and can we demonstrate that agreement with repeatable physical checks?

## What we are working toward

The digital model is already checked against its source drawing, STEP reference and normal build/verification tests. The next level is different: **checking the dimensions and mechanical features represented by the model against a real physical panel**.

We are not trying to verify the whole panel in one session. Instead, the broader physical validation plan is being turned into small test cases. Each testcase should answer one clear question, identify the physical sample and fixture revisions used, describe a repeatable action or measurement, and retain the observation/evidence.

This keeps three things separate:

1. **test definition** — what physical question are we trying to answer?
2. **fixture implementation** — what printed helper, if any, makes that question repeatable?
3. **physical evidence** — what did we actually observe on a named real panel?

A successful printed fit is therefore not automatically proof that a model dimension is correct.

## Start here

The broader procedure remains in [`physical-panel-validation.md`](physical-panel-validation.md). It starts with one recognizable area: the **upper-left corner viewed from the rear**.

The first question extracted into its own testcase is **SQ-01 — TL1 square placement with SQ1**:

- [Nederlands — TL1 haaks plaatsen met SQ1](top-left/test-cases/sq-01-tl1-haaks-plaatsen-met-sq1.nl.md)
- [English — Hold TL1 square with SQ1](top-left/test-cases/sq-01-hold-tl1-square-with-sq1.en.md)

SQ-01 checks only whether an SQ1 alignment helper can place a TL1 profile helper at that corner **squarely and repeatably without forcing it**. It deliberately does not decide whether the TL1 profile dimensions agree with the real panel; that belongs in a separate testcase.

Use [`test-case-template.md`](test-case-template.md) when extracting the next physical question.

## Current status

SQ-01 is **defined but not yet physically executed**.

A first fixture implementation (TL1 v0.2 and SQ1 v0.2) was developed while exploring this workflow in PR #19. That larger experimental PR is being closed rather than kept open for weeks. Its fixture/CAD changes are therefore not treated as accepted `main` state.

When physical verification resumes:

1. reassess the testcase against the current library state;
2. confirm or recreate the fixture revisions needed by the testcase;
3. qualify/publish those fixtures;
4. execute the testcase on an identified physical panel;
5. record result and evidence;
6. extract the next dimensional question from the validation plan.

The compact verification catalogue in [`measurement-catalog.yml`](measurement-catalog.yml) remains a roadmap/checklist of model features that still need physical confirmation. It is not itself the operator procedure and is intentionally not a store for raw measurements or photographs.

Raw vendor/source material, physical sample measurements and supporting photos should eventually live in a separate companion data repository. The proposed repository is `lib.scad.hub75.data`; the library should only retain the small accepted verification baseline and a provenance link/commit to the data that justified it.

Functional software verification is currently generated from `test/hub75_p5_64x32_panel_api.scad`.

Generated STL/images/evidence are written below `vrf/out/` and are not committed to `main`.