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
      <a href="../../blob/prod/build/design/project/openscad/p5-64x32-panel/design/img/01-front.png">
        <img src="../../raw/prod/build/design/project/openscad/p5-64x32-panel/design/img/01-front.png" alt="HUB75 P5 64 x 32 panel front angled view" width="100%">
      </a>
    </td>
    <td align="center">
      <a href="../../blob/prod/build/design/project/openscad/p5-64x32-panel/design/img/02-rear.png">
        <img src="../../raw/prod/build/design/project/openscad/p5-64x32-panel/design/img/02-rear.png" alt="HUB75 P5 64 x 32 panel rear angled view" width="100%">
      </a>
    </td>
  </tr>
</table>

These angled images are generated from the current `prod/build` branch.

## Quick links

- [HUB75 panel design source](openscad/p5-64x32-panel/design/design.md)
- [HUB75 panel manual/reference](openscad/p5-64x32-panel/manual.md)
- [Generated HUB75 panel design documentation](https://github.com/brainboxemb/lib.scad.hub75/blob/prod/build/design/project/openscad/p5-64x32-panel/design/design.md)
- [HUB75 panel OpenSCAD source](openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad)
- [Latest generated build](../../tree/prod/build)
- [Functional verification](../../tree/prod/verification)
- [Changelog](CHANGELOG.md)

The first component is the portrait-oriented HUB75 P5 64 × 32 pixel panel model. Its nominal landscape dimensions are 320 × 160 mm; consumers may orient the model vertically without changing the library geometry.

```text
openscad/p5-64x32-panel/
├── hub75_p5_64x32_panel.scad
├── hub75_p5_64x32_panel_render.scad
├── manual.md
└── design/
    └── design.md
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

Source design documentation lives beside the component at:

```text
openscad/p5-64x32-panel/design/design.md
```

`tool.scad-project design-build` renders the readable generated copy under `bld/design`. Successful production builds publish that generated documentation to `prod/build`; generated PNGs do not belong on `main`.

The design narrative is reader-first: it explains the physical feature and geometric operation before using source snippets as supporting detail. The manual remains separate and covers usage, reference dimensions and interactive views.

## Verification

`test/hub75_p5_64x32_panel_api.scad` exercises the public object API, checks derived values and builds the complete panel. Successful functional evidence is published to `prod/verification`.

A release reruns Build and Verify against the exact release source before publishing immutable snapshots under:

```text
rel/vX.Y.Z/build
rel/vX.Y.Z/verification
```

and creating the matching annotated source tag and GitHub Release bundles.

## Project tooling

The current `tool.scad-project` dependency is declared in `project.yml`, locked by the `tools/tool.scad-project` gitlink and matched by the reusable workflow commit pins. Keep those three representations aligned.

Bootstrap and dependency updates are Python-free:

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
