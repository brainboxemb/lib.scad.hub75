# lib.scad.hub75

Reusable OpenSCAD reference geometry for HUB75 LED matrix hardware.

## Quick links

- [HUB75 panel design source](openscad/p5-64x32-panel/design/design.md)
- [HUB75 panel manual/reference](openscad/p5-64x32-panel/manual.md)
- [Generated HUB75 panel design documentation](https://github.com/brainboxemb/lib.scad.hub75/blob/build/design/project/openscad/p5-64x32-panel/design/design.md)
- [HUB75 panel OpenSCAD source](openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad)
- [Build provenance](../../blob/build/publication-info.txt)
- [Verification provenance](../../blob/verification/publication-info.txt)

The first component is the portrait-oriented HUB75 P5 64 × 32 pixel panel (nominal 320 × 160 mm) model:

```text
openscad/p5-64x32-panel/
├── hub75_p5_64x32_panel.scad
├── hub75_p5_64x32_panel_render.scad
└── design/
    └── design.md
```

## Public API

Private implementation helpers, including helpers nested inside other modules,
use a leading `_` consistently with the BOSL2 naming convention. Names without
a leading underscore are reserved for supported library-facing API.


The library uses the OpenSCAD object model:

```scad
use <openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>

panel = hub75_p5_64x32_panel_create();

hub75_p5_64x32_panel_build(panel);
```

Mechanical information belongs to the object. Consumers should use the object
or object-based accessor functions instead of duplicating panel dimensions.

Examples:

```scad
hub75_p5_64x32_panel_width(panel);
hub75_p5_64x32_panel_height(panel);
hub75_p5_64x32_panel_hole_x_positions_centered(panel);
hub75_p5_64x32_panel_rear_grid_gap_x(panel);
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

The HUB75 panel design document explains the physical construction for a reader
who does not need to know OpenSCAD. It uses a deliberately small set of
generated views: only images that add explanatory value belong in the
walkthrough. Additional technical/debug views remain available through the
OpenSCAD Customizer.

Usage, placement/reference dimensions and interactive render-view selection are
kept separately in the panel manual.


Source documentation lives at:

- [openscad/p5-64x32-panel/design/design.md](openscad/p5-64x32-panel/design/design.md)

After CI generates the design renders, the readable generated version is
published on the `build` branch:

- [Generated HUB75 panel design documentation](https://github.com/brainboxemb/lib.scad.hub75/blob/build/design/project/openscad/p5-64x32-panel/design/design.md)

The design document is the engineering description of the component. It starts
with recognisable front/rear views and then explains the rear frame, recess,
mounting features, reinforcement, locator pins and connector reference geometry
in physical terms before showing supporting code.

Generated images belong below `bld/design/` and on the mutable `build` branch,
not on `main`.

## Verification

`test/hub75_p5_64x32_panel_api.scad` exercises the public object API, validates key
derived values and builds the complete panel.

Generated functional evidence is published separately to the
`verification` branch.

## Project tooling

This repository pins `tool.scad-project` v0.6.1:

```yaml
tooling:
  tool_scad_project:
    type: git-submodule
    url: https://github.com/brainboxemb/tool.scad-project.git
    path: tools/tool.scad-project
    ref: v0.6.1
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

## Design documentation philosophy

Design documentation is intended to make CAD construction understandable, not
merely to list source code.

A reader should be able to understand the physical model, follow how geometry
is added or removed, and identify possible modelling errors without first
knowing OpenSCAD.

```text
physical meaning → geometric change → image → supporting code
```

The generated images are therefore part of the explanation: gray shows the
existing construction state and red identifies the current operation or
feature.
