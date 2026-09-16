# Scripts

The scripts in this directory generate repository verification output. They are
part of the HUB75 model's **functional and physical-verification** layer, not a
second implementation of the shared CI/migration policy.

Migration-005 integration details such as exact tool pins, Moon capability
selection, runtime profile and SCons transport are qualified by the shared
`tool.scad-project` planner/workflow and the PR CI evidence. They are
intentionally not re-tested here by grepping workflow or `moon.yml` text.

## Functional and physical verification

Run inside the shared SCAD toolchain environment:

```bash
bash ./scripts/run-verification.sh
bash ./scripts/build-verification-index.sh
```

### `run-verification.sh`

This script verifies model behaviour and generates the evidence consumed at the
workbench.

It performs four kinds of checks:

1. **Public API smoke test** — exports
   `vrf/out/hub75-p5-64x32-panel-api.stl` from the separate consumer fixture in
   `test/`.
2. **Stage-1 top-left profile-comb fixture** — exports the printable STL and an
   auto-fitted PNG preview for the first physical panel procedure.
3. **Operator-plan views** — renders the location, feature-map, comb-use and
   comb-side images with the cameras defined by their `.scad` adapters. These
   images deliberately do not use `--autocenter`/`--viewall`, because that would
   replace the authored close-up framing.
4. **Later-stage gauges** — exports and previews the corner datum, 144 mm X
   mounting-spacing and 152 mm Z mounting-spacing helpers retained for later
   physical checks.

OpenSCAD exit code 0 alone is not accepted as success. The wrapper also rejects
fatal warning classes such as unknown functions/modules, undefined-operation
propagation, failed conversions and invalid-manifold warnings. Ordinary camera
notices remain allowed.

Generated files live under:

```text
vrf/out/
vrf/out/fixtures/
vrf/out/plan/
```

### `build-verification-index.sh`

This script does not run CAD. It creates `vrf/out/README.md` as the browseable
verification page for the generated-output branch.

The page:

- links the Stage-1 fixture download and preview;
- embeds the operator procedure from `vrf/physical-panel-validation.md` so the
  verification branch is usable without switching back to the source branch;
- rewrites image links for the isolated generated branch;
- lists the later-stage fixture downloads separately.

The source procedure remains authoritative. The generated README is publication
output and should not be edited by hand.

## CI relationship

`project.scad.yml` invokes both scripts as the repository's `scad.verify`
commands. The shared tool remains responsible for selecting the OpenSCAD-focused
runtime, deciding whether Verification-SCons cache transport is applicable,
hydrating/running the Moon capability and publishing `vrf/out`.

Keeping those orchestration checks outside these scripts means the verification
content answers the useful question: **does the model/API and the physical
verification material still work?**
