# HUB75 library plan

## Purpose

`lib.scad.hub75` owns reusable mechanical reference models for HUB75 hardware.
The current primary component is the P5 64 × 32 panel.

The durable rationale and boundaries are in
[10-specification.md](10-specification.md).

## Working method

For normal library work:

1. understand the intended reference-model meaning in
   [10-specification.md](10-specification.md);
2. read [20-design.md](20-design.md) for repository/component architecture;
3. read the affected component's local `design/design.md` before changing
   non-trivial geometry;
4. use the component manual/source for exact usage, dimensions and public API;
5. read [30-verification.md](30-verification.md) before changing verification
   meaning, procedures or evidence;
6. keep physical observations separate from model targets until they have been
   reviewed and accepted.

Do not change geometry merely to make an unqualified printed helper fit.

## Information sources

| Question | Authority |
| --- | --- |
| Work scope, sources, current focus and roadmap | this plan |
| Shared BrainboxEmb working guidance | [`brainboxemb.meta/AGENTS.md`](https://github.com/brainboxemb/brainboxemb.meta/blob/main/AGENTS.md) |
| Shared SCAD domain guidance | [`brainboxemb.meta/domains/scad/README.md`](https://github.com/brainboxemb/brainboxemb.meta/blob/main/domains/scad/README.md) |
| Why this reference library/model exists | [10-specification.md](10-specification.md) |
| Repository/component architecture | [20-design.md](20-design.md) |
| Detailed physical construction | [panel design](../openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md) |
| Panel usage/reference/API | [panel manual](../openscad/p5-64x32-panel/manual.md) and public `.scad` source |
| Verification strategy/current physical status | [30-verification.md](30-verification.md) |
| Executable physical procedures/testcases/fixtures | [`vrf/`](../vrf/README.md) |
| Exact tooling intent and pins | `project.yml`, `project.scad.yml`, committed gitlinks and workflow callers |
| Exact pinned tool behavior | pinned dependency README/docs/source/tests |
| Current automation/runtime status | live GitHub Actions plus `prod/bld` / `prod/vrf` provenance |
| Source dimensions/provenance | hierarchy recorded in specification, component design and source comments |

## Current focus

The model has strong source-based and functional verification, but systematic
physical comparison with a real panel is still incomplete.

The first extracted physical testcase, SQ-01, is defined but has not yet been
physically executed. The exploratory TL1/SQ1 fixture revisions developed in the
closed, unmerged PR #19 are not accepted main-state fixtures.

## Roadmap

When physical verification resumes:

1. reassess SQ-01 against current main;
2. confirm or recreate the required fixture revisions;
3. qualify and publish those fixtures;
4. execute SQ-01 on an identified physical panel;
5. retain observations/evidence without silently changing nominal model values;
6. continue with the next small physical question;
7. expand toward envelope, complete mounting pattern, rear mating geometry and
   other local features only after the earlier checks are usable.

Cross-project tooling/documentation changes remain owned by their shared
repositories and migrations rather than this library plan.
