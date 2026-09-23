# HUB75 physical verification material

Repository-level verification strategy and current physical status are owned by
[../doc/30-verification.md](../doc/30-verification.md).

This directory contains the **executable/workbench material** used to perform and
publish physical verification.

## Start here

- [Physical panel procedure](physical-panel-validation.md)
- [SQ-01 — TL1 haaks plaatsen met SQ1](top-left/test-cases/sq-01-tl1-haaks-plaatsen-met-sq1.nl.md)
- [SQ-01 — Hold TL1 square with SQ1](top-left/test-cases/sq-01-hold-tl1-square-with-sq1.en.md)
- [Testcase template](test-case-template.md)
- [Measurement catalogue](measurement-catalog.yml)

Fixture and render sources live below `fixtures/` and `top-left/`.

Generated STLs, images and execution evidence are written below `vrf/out/` and
published to the configured Verification branch. They are generated evidence,
not raw physical observations and not a replacement for an executed testcase.

The current physical status is intentionally not duplicated here; read
[doc/30-verification.md](../doc/30-verification.md) and the individual testcase
being performed.
