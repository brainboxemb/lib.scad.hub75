# SQ-01 — Hold TL1 square with SQ1

**Question**

Can SQ1 hold TL1 square and in a repeatable position at the upper-left panel corner without forcing or twisting either part?

This test checks **placement and repeatability only**. Whether the TL1 profile agrees with the real panel geometry and dimensions belongs in a separate test case.

**Status**

`defined` — not yet physically executed.

The first development version of this test used TL1 v0.2 and SQ1 v0.2 in PR #19. That fixture implementation is not being merged to `main` with this documentation slice. Before execution, the fixture revisions to be used must be confirmed and published again.

**Needed**

- one physical P5 64 × 32 panel with a sample ID;
- an approved TL1 revision;
- the matching approved SQ1 revision;
- phone or camera.

**Before**

Place the panel with the rear/electronics side facing you and the 320 mm direction vertical. Use the physical upper-left corner marked in the existing verification output.

<img src="https://raw.githubusercontent.com/brainboxemb/lib.scad.hub75/prod/vrf/plan/top-left-location.png" alt="Upper-left verification area on the rear of the panel" width="52%">

| # | Action | Expected |
| ---: | --- | --- |
| 1 | Slide SQ1 over TL1. | SQ1 moves over TL1 without force. Some functional slot clearance is acceptable. |
| 2 | Put SQ1 on the straight front part of the panel's top edge at the upper-left corner. | SQ1 rests on the intended edge and TL1 points across the panel depth. |
| 3 | Let the two parts settle with light hand contact. Do not twist TL1 to make it look correct. | SQ1 sits naturally and holds TL1 approximately perpendicular to the top edge. |
| 4 | Remove both parts and repeat the placement three times. | The same position and orientation can be found each time. |
| 5 | While seated, check gently for obvious rocking. | No obvious rocking. If it rocks or the seating is unclear, record `investigate` and take a close photo. |
| 6 | Record the result and take one photo of the seated parts. | The record contains a result, observation and evidence reference. |

**Record**

- Sample: `...`
- Date: `...`
- TL1 revision: `...`
- SQ1 revision: `...`
- Result: `agrees` / `investigate` / `not checked`
- Observed: `...`
- Evidence: `...`
- Follow-up: `...`
