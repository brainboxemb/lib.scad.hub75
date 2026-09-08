# lib.scad.hub75

Reusable OpenSCAD reference geometry for HUB75 LED matrix hardware.

The first component is the portrait-oriented HUB75 P5 64 × 32 panel model:

```text
openscad/hub75-panel/
├── hub75_panel.scad
├── hub75_panel_render.scad
└── design/
    └── design.md
```

## Public API

The library uses the OpenSCAD object model:

```scad
use <openscad/hub75-panel/hub75_panel.scad>

panel = hub75_panel_create();

hub75_panel_build(panel);
```

Mechanical information belongs to the object. Consumers should use the object
or object-based accessor functions instead of duplicating panel dimensions.

Examples:

```scad
hub75_panel_width(panel);
hub75_panel_height(panel);
hub75_panel_hole_x_positions_centered(panel);
hub75_panel_rear_grid_gap_x(panel);
hub75_rear_side_rail_width_at_mounting_plane(panel);
```

The OpenSCAD implementation requires the `object()` experimental feature.
Project tooling passes:

```text
--enable=object-function
```

automatically.

## Geometry provenance

The supplied source model records these references:

- `Hub75 P5 Matrix Panel.step`;
- `2277_P5_320x160mm_64x32+pixel.pdf`;
- a rear-panel photograph as secondary visual reference.

The library preserves the measurements and qualification already present in
that source. In particular, drawing-derived dimensions and STEP/photo
approximations remain distinguished in the design documentation.

## Design documentation

Source documentation lives at:

```text
openscad/hub75-panel/design/design.md
```

It declares generated views for:

- final model;
- front;
- rear;
- rear structure;
- connectors;
- drawing verification;
- profile/mating plane.

Generated images belong below `bld/design/` and on the mutable `build` branch,
not on `main`.

## Verification

`test/hub75_panel_api.scad` exercises the public object API, validates key
derived values and builds the complete panel.

Generated functional evidence is published separately to the
`verification` branch.

## Project tooling

This repository pins `tool.scad-project` v0.4.4:

```yaml
tooling:
  tool_scad_project:
    type: git-submodule
    url: https://github.com/brainboxemb/tool.scad-project.git
    path: tools/tool.scad-project
    ref: v0.4.4
```

Bootstrap and repository updates are Python-free:

```powershell
.\bootstrap.ps1
.\update-repo.ps1
```

Normal repository operations initialize direct dependencies only. If this
library is consumed as a submodule, its own `tools/tool.scad-project`
development dependency is not recursively initialized by the parent project.

The model, code and documentation are being developed with the assistance of
ChatGPT.
