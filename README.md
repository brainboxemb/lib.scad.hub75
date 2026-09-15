# lib.scad.hub75

Reusable OpenSCAD mechanical reference geometry for HUB75 LED matrix hardware.

## Preview

<table>
  <tr>
    <th align="center">Front angled</th>
    <th align="center">Rear angled</th>
  </tr>
  <tr>
    <td align="center">
      <a href="../../blob/prod/build/png/hub75-p5-64x32-panel-front-angled.png">
        <img src="../../raw/prod/build/png/hub75-p5-64x32-panel-front-angled.png" alt="HUB75 P5 64 x 32 panel front angled view" width="100%">
      </a>
    </td>
    <td align="center">
      <a href="../../blob/prod/build/png/hub75-p5-64x32-panel-rear-angled.png">
        <img src="../../raw/prod/build/png/hub75-p5-64x32-panel-rear-angled.png" alt="HUB75 P5 64 x 32 panel rear angled view" width="100%">
      </a>
    </td>
  </tr>
</table>

These angled presentation images are dedicated build outputs from the current `prod/build` branch; they are not design-documentation renders.

## Quick links

- [HUB75 panel design source](openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md)
- [HUB75 panel manual/reference](openscad/p5-64x32-panel/manual.md)
- [Generated HUB75 panel design documentation](https://github.com/brainboxemb/lib.scad.hub75/blob/prod/build/design/project/openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md)
- [HUB75 panel OpenSCAD source](openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad)
- [Physical verification work](vrf/README.md)
- [Latest generated build](../../tree/prod/build)
- [Functional verification](../../tree/prod/verification)
- [Changelog](CHANGELOG.md)

The first component is the portrait-oriented HUB75 P5 64 × 32 pixel panel model. Its nominal placement size is 160 × 320 mm (width × height), matching the library's native portrait coordinate system.

```text
openscad/p5-64x32-panel/
├── hub75_p5_64x32_panel.scad
├── manual.md
└── hub75_p5_64x32_panel/
    ├── hub75_p5_64x32_panel_render.scad
    ├── design/
    │   └── design.md
    └── render/
        ├── render.yml
        ├── hub75-p5-64x32-panel-front-angled.scad
        └── hub75-p5-64x32-panel-rear-angled.scad
```

## Public API

The library uses the OpenSCAD `object()` model:

```scad
use <openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_build(panel);
```

Mechanical information belongs to the panel object. Consumers should use the object and public accessor functions instead of duplicating panel dimensions.

Representative accessors include:

```scad
hub75_p5_64x32_panel_width(panel);
hub75_p5_64x32_panel_height(panel);
hub75_p5_64x32_panel_rear_grid_gap_x(panel);
hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel);
hub75_p5_64x32_panel_rear_crossbar_width_at_mounting_plane(panel);
hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
```

Private implementation helpers use a leading `_` consistently with the BOSL2-style naming convention. Names without a leading underscore are reserved for supported cross-file API.

The implementation requires OpenSCAD's experimental object feature. Project tooling supplies:

```text
--enable=object-function
```

## Geometry authority

The source model records and preserves the distinction between its references:

- the dimensional drawing for authoritative envelope and mounting dimensions;
- the STEP model for rear taper/mechanical form where documented;
- a rear-panel photograph only for secondary visual/orientation evidence.

Do not silently promote a STEP/photo approximation into a drawing-derived dimension. Project-specific mating parts should consume the library accessors rather than recreating those measurements.

## Design documentation

Source design documentation lives beside the supporting files for the component at:

```text
openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md
```

`tool.scad-project design-build` renders the readable generated copy under `bld/design`. Successful production builds publish that generated documentation to `prod/build`; generated PNGs do not belong on `main`.

The design narrative is reader-first: it explains the physical feature and geometric operation before using source snippets as supporting detail. The manual remains separate and covers usage, reference dimensions and interactive views.

## Verification

`test/hub75_p5_64x32_panel_api.scad` exercises the public object API, checks derived values and builds the complete panel. Successful functional evidence is published to `prod/verification`.

In parallel, the library is building up **physical dimension verification against real HUB75 hardware**. That work is deliberately broken into small test cases: one physical question, one repeatable procedure and one recorded result at a time. The first defined case, SQ-01, checks whether TL1 can be positioned squarely and repeatably with an SQ1 alignment helper; it does not yet prove the TL1 profile dimensions themselves. See [`vrf/README.md`](vrf/README.md) for the current approach and testcase links.

## Migration 005 capability model

Normal pull-request and `main` production uses the released Migration-005 lifecycle from `tool.scad-project v0.14.2`.

HUB75 exposes three real capabilities:

```text
scad.docs
    generated design documentation

scad.build
    standalone front/rear presentation renders

scad.verify
    API verification plus physical-verification fixtures and plan images
```

Root `moon.yml` selects these inherited capabilities through `workspace.inheritedTasks.include` and adds only HUB75-specific source-impact inputs. Shared commands, standard outputs and Moon cache policy are inherited through:

```text
.moon/tasks/scad.yml
    -> tools/tool.scad-project/moon/tasks/scad.yml
```

Consumer-authored Migration-004 lifecycle tasks such as build-index/provenance, `scad.production-impact` and `scad.ci` are no longer part of the repository graph.

One host-side Moon affected query can stop unrelated changes before acquiring a CAD runtime. When work is affected, the shared planner derives runtime/cache policy from `project.scad.yml` and materializes the required capabilities in at most one CAD process.

This repository deliberately stays **OpenSCAD-only** and keeps:

```yaml
build_engine:
  engine: scons
```

so it is the Migration-005 focused-runtime/SCons canary. The planner should select `ghcr.io/brainboxemb/scad-toolchain-openscad:v0.5.0`; applicable normal SCons cache transport remains enabled. Verification-SCons transport is only expected when configured verification render/export targets genuinely populate it—command-only verification must not create a cache transport requirement merely because the project uses SCons for normal Build/docs work.

Moon and SCons therefore have distinct jobs:

```text
Moon     coarse capability impact + whole-capability reuse
SCons    fine-grained target reuse inside executing SCons capabilities
```

Normal successful CI publishes changed Build/Verification families and retains compact orchestration evidence instead of uploading another complete copy of those output trees as Actions artifacts.

A release reruns Build and Verify against the exact release source before publishing immutable snapshots under:

```text
rel/vX.Y.Z/build
rel/vX.Y.Z/verification
```

and creating the matching annotated source tag and GitHub Release bundles.

## Project tooling

Repository-level Git/dependency policy and SCAD-domain policy remain split:

```text
project.yml
    generic project/profile/dependency policy

project.scad.yml
    SCAD paths, OpenSCAD/build-engine, verification and publication policy

moon.yml
    visible capabilities + HUB75-specific source-impact boundaries

.moon/tasks/scad.yml
    inherited shared SCAD capability implementation
```

The released foundation is locked in three complementary forms:

```text
project.yml
    tool.scad-project ref: v0.14.2

tools/tool.scad-project
    exact source: 5712324ea9e3a7c81ba1b79013f2758f52b219cf

.github/workflows/scad.yml / release.yml
    exact reusable workflow source: 5712324ea9e3a7c81ba1b79013f2758f52b219cf

tools/tool.git-project
    exact source: 7c43f37e7b07cfb57638a1d1dad2501de09ba7eb
```

PR-preview cleanup uses released `tool.git-project v0.2.8`.

Bootstrap and dependency updates remain Python-free:

```powershell
.\bootstrap.ps1
.\update-repo.ps1
```

or:

```bash
bash ./bootstrap.sh
bash ./update-repo.sh
```

Normal checkout initializes direct dependencies only. When this library is consumed as a submodule, a parent project does not recursively initialize this library's own development-tooling submodule.

Repository-specific agent guidance is in [`AGENTS.md`](AGENTS.md).

The model, code and documentation were developed with the assistance of ChatGPT.
