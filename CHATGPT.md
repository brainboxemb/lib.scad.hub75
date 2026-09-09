# CHATGPT.md

## Repository purpose

`lib.scad.hub75` contains reusable mechanical reference models for HUB75
hardware.

The first component is `openscad/p5-64x32-panel`.

## OpenSCAD architecture

OpenSCAD is the primary implementation.

Public data must use the OpenSCAD `object()` model:

```text
hub75_p5_64x32_panel_create(...)
    -> panel object

hub75_p5_64x32_panel_build(panel)
    -> final geometry

hub75_p5_64x32_panel_render(panel, view)
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

Design renders use `hub75_p5_64x32_panel_render.scad` and stable named views.

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

For HUB75 design views use the public `hub75_p5_64x32_panel_view_*()` functions rather
than `HUB75_P5_64X32_PANEL_VIEW_*` variables across a `use` boundary.

## Design-documentation depth

`design.md` must be an engineering/design narrative, not merely a list of
render views.

For HUB75 components it should explain, where applicable:
- geometry source and authority;
- coordinate/orientation choices;
- object/API model;
- construction sequence;
- derived mating dimensions;
- distinction between drawing-, STEP- and photo-derived geometry;
- intentional limitations.

Use source snippets to explain key geometry decisions, following the
`lib.scad.clamps` design-documentation style.

## HUB75 design-render rule

Follow the same architecture as `lib.scad.clamps`:

- `hub75_p5_64x32_panel_render.scad` is a small interface only;
- it maps stable string view names to numeric `hub75_p5_64x32_panel_render()` views;
- actual design geometry stays in `hub75_p5_64x32_panel.scad`;
- design views reuse the same private helpers as the production build;
- do not implement a second copy of panel geometry in the render adapter.

The renderer may expose many fine-grained diagnostic views, but design.md
should use only the subset that improves understanding. Do not create or keep a
render in the narrative merely because a helper or intermediate coordinate
exists.

Prefer one useful overview plus representative close-ups over a catalogue of
nearly identical views.



## Component naming

The repository is generic: `lib.scad.hub75`.

The current component is specific:
- directory: `openscad/p5-64x32-panel`;
- source/API prefix: `hub75_p5_64x32_panel_*`;
- view constants: `HUB75_P5_64X32_PANEL_VIEW_*`.

It models a HUB75 P5 64 × 32 pixel panel with nominal 320 × 160 mm landscape
dimensions, although a consumer may orient it vertically.

## OpenSCAD constant visibility

File-level variables/constants do not cross an OpenSCAD `use <...>` boundary.

For named design/render views:
- keep authoritative `HUB75_P5_64X32_PANEL_VIEW_*` constants in
  `hub75_p5_64x32_panel.scad`;
- expose one `hub75_p5_64x32_panel_view_id(view)` conversion function;
- do not create one accessor function per constant;
- do not duplicate numeric view IDs in the render adapter.

## Design image framing

Generated design images are part of the explanation, not merely proof that a
view renders.

For small HUB75 features:
- use exact `vpt`/`vpd` cameras centred on the feature;
- do not auto-fit the full 159.7 × 319.71 mm panel for a 3–14 mm detail;
- show a local construction sequence first, then an overview where repetition
  or placement matters;
- use thin design-only sections when a depth/profile view would otherwise
  collapse into an edge-on line;
- inspect the generated build images after camera/design changes.

## Rear-frame staged design context

Do not use completed `rear_frame_structure()` as the gray context for an
operation that is already part of that final geometry.

Use the production states:
- `rear_frame_base()`;
- `rear_frame_after_recess()`;
- `rear_frame_after_mounting_reliefs()`;
- `rear_frame_with_mounting_tubes()`;
- `rear_frame_after_reinforcement_cuts()`;
- `rear_frame_structure()`.

A design view uses the state immediately before the highlighted operation.

Default HUB75 design-render resolution: 1600 × 1200 px.

## Reader-first design documentation

Assume the reader may not know OpenSCAD or PythonSCAD. Documentation exists to
create understanding, not to document code for its own sake.

For a meaningful construction step, explain the physical feature first, then
its geometric change, then show an image that makes that exact change visible,
and only then use source code as supporting detail.

Start component walkthroughs with recognisable front and rear overview views.
Use gray for the state before an operation and red for the current
addition/removal/highlight. Completed after-states return to neutral.

Choose the camera for the geometry: orthographic for flat placement geometry,
rear-oblique close-ups for protruding rear features, and explicit
sections/profiles for depth questions.

A good quality test is whether the reader can identify and describe a modelling
error from the explanation and image without knowing the CAD language.

## View table rule

Keep one sequential view ID space and one table of `[CONSTANT, "stable-name"]`
rows. The constant value must equal the row index. This deliberate duplication
acts as a C-style integrity check.

Access a numeric row through `hub75_p5_64x32_panel_view_entry()`, which asserts
that `VIEW_TABLE[view][0] == view`. Stable documentation names are converted
through the same table; do not maintain a second long conditional mapping.


## Design versus manual/reference

Keep two concerns separate:

- `design/design.md` explains how the physical geometry is constructed;
- `manual.md` explains usage, placement/reference dimensions, object accessors
  and the interactive Customizer/render views.

Physical versus nominal placement dimensions do not need multiple generated
design images unless an image genuinely improves understanding.

Internal coordinate/depth planes are normally debug views, not design-document
content.

Every generated image used in design.md must have the stable view name written
next to it, for example:

```markdown
**View:** `mounting-tube-single`
```

This lets a reader select the same view in the OpenSCAD Customizer when
investigating a problem.
