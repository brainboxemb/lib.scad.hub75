# CHATGPT.md

## Repository purpose

`lib.scad.hub75` contains reusable mechanical reference models for HUB75
hardware.

The first component is `openscad/hub75-panel`.

## OpenSCAD architecture

OpenSCAD is the primary implementation.

Public data must use the OpenSCAD `object()` model:

```text
hub75_panel_create(...)
    -> panel object

hub75_panel_build(panel)
    -> final geometry

hub75_panel_render(panel, view)
    -> design/debug geometry
```

Do not reintroduce a public API consisting of many unrelated global scalar
functions with hidden file-level state. Derived accessors must take the panel
object.

The object function feature is enabled through project tooling with
`--enable=object-function`.

## Geometry authority

Preserve the distinctions already recorded in the supplied source:

- dimensional drawing for authoritative basic envelope/mounting dimensions;
- STEP for taper and rear mechanical form where noted;
- rear photograph only for secondary visual/orientation references where noted.

Do not silently promote a photo/STEP approximation into a drawing-derived
dimension.

Coordinate system:
- X = width, centred;
- Y = front to rear, front face Y=0;
- Z = height, centred.

## Design documentation

Every meaningful component has `design/design.md`.

The HUB75 panel design document should explain:
- coordinate/orientation;
- object data model;
- front envelope;
- rear structure/taper;
- mounting tubes, reinforcement bushings and locator pins;
- connectors/orientation references;
- PDF/drawing verification overlay;
- rear mounting plane and mating dimensions.

Design renders use `hub75_panel_render.scad` and stable named views.

Generated PNG/STL files do not belong on `main`.

## Repository workflow

Pin `tool.scad-project` at `tools/tool.scad-project`.

Current intended tool ref: `v0.4.4`.

Use thin reusable GitHub workflow callers.

Normal submodule operations are direct-only. Do not recursively initialize a
consumer dependency's own development submodules.

Branches:
- `main`: source/design/tests;
- `build`: generated design/build output;
- `verification`: generated functional/API verification evidence.

Root bootstrap/update scripts are canonical copies from `tool.scad-project`
and must remain Python-free.

## OpenSCAD use-boundary rule

`use <...>` imports modules and functions, but file-level variables are not a
public cross-file API. Values needed by render adapters must therefore be
exposed through functions or defined locally.

For HUB75 design views use the public `hub75_panel_view_*()` functions rather
than `HUB75_PANEL_VIEW_*` variables across a `use` boundary.

