# Repository agent guidance

Persistent guidance for automated coding agents working in `lib.scad.hub75`.

## Repository purpose

`lib.scad.hub75` contains reusable mechanical reference models for HUB75
hardware. The current primary component is `openscad/p5-64x32-panel`.

## Sources of truth

Use:

```text
component source + design documentation     geometry/API intent
project.yml                                 tool/dependency policy
.gitlinks / .gitmodules                     resolved dependency state
source references noted in design docs      dimensional authority
```

Do not duplicate volatile `tool.scad-project` versions in this file. The active
release is declared in `project.yml` and resolved by the gitlink/workflow refs.

## OpenSCAD architecture

OpenSCAD is the primary implementation.

Public data uses the `object()` model:

```scad
panel = hub75_p5_64x32_panel_create(...);
hub75_p5_64x32_panel_build(panel);
hub75_p5_64x32_panel_render(panel, view);
```

Derived accessors must receive the panel object. Do not reintroduce a public API
of unrelated global scalar state.

The object-function feature is enabled by project tooling.

## Naming

Use the BOSL2-style convention consistently:

```text
public cross-file function/module    no leading underscore
private implementation helper       leading underscore
nested/local private helper          leading underscore
```

Scope does not replace naming intent.

Global OpenSCAD constants must be component-prefixed. Named design/render views
use one sequential table and one conversion function; do not maintain duplicate
numeric mappings across files.

## Geometry authority

Preserve the documented source hierarchy:

- dimensional drawing for authoritative envelope/mounting dimensions;
- STEP for taper/rear mechanical form where explicitly recorded;
- photographs only for secondary visual/orientation evidence where recorded.

Do not silently promote an approximation into a drawing-derived dimension.

Coordinate system:

```text
X = width, centred
Y = front to rear, front face Y=0
Z = height, centred
```

Consumers may orient the panel differently, but the library geometry remains in
its native coordinate system.

## Design documentation

Each meaningful component has `design/design.md`.

Design documentation must explain the physical model in reader-first order:

1. physical feature/purpose;
2. geometric change;
3. image that makes that change visible;
4. code/helper only as supporting detail.

Assume the reader does not know OpenSCAD. A good design document should let a
reader identify a modelling error from the explanation and image alone.

Start with recognizable front/rear overviews. For construction steps, use
neutral context for the previous state and a contrasting highlight for the
current operation. Use orthographic, oblique close-up, or section views according
to the geometry being explained.

Generated images belong under `bld/`; do not commit generated `design/img/`
output to `main`.

`manual.md` and `design/design.md` have different jobs:

```text
design/design.md    how the physical geometry is constructed
manual.md           usage, placement/reference dimensions, API and views
```

Every generated image used in design documentation should expose its stable view
name so the same view can be selected during debugging.

## Physical verification documentation

`vrf/` must be written as an executable physical procedure, not only as a list
of dimensions or planned fixtures. Assume the person performing verification has
the real panel, normal measuring tools and the printed helper, but has not read
the OpenSCAD source.

Start locally. Prove one recognizable area of the panel before introducing long
spacing bars or a large catalogue of unrelated checks.

Every physical verification procedure must show and explain:

1. which side/orientation and exact physical area is being checked;
2. the datum surfaces/edges used to position the measurement or helper;
3. a feature map naming each feature that will be checked;
4. the required tool or printed helper and its visible version marking;
5. exactly how the helper is placed on the real panel;
6. the expected model value and the public accessor/source behind that value;
7. what the operator records;
8. what counts as `agrees`, `investigate` or `not checked`.

A printable verification helper is incomplete until documentation includes both
a clear render of the helper by itself and a render showing it in the intended
position on the model. Prefer additional close-up/section renders where they make
contact, taper or depth checks unambiguous.

Printed helpers should be small and question-specific. Do not combine unrelated
measurements merely to reduce the number of STLs. Put a short stable identifier
and fixture version on the physical part, for example `TL1 v0.1`, so recorded
measurements can identify the exact helper that was used.

Generated verification images/STLs are evidence and belong below `vrf/out/` on
the configured verification publication branch, not on `main`.

## Render architecture

Keep render adapters small. They translate stable view names and call the public
component render API. Actual geometry stays in the component source and reuses
the same private helpers as production geometry.

Do not implement a second copy of panel geometry in render adapters.

For detailed features, frame the feature itself; do not auto-fit an entire panel
when the subject is only a few millimetres across. Use explicit sections when a
depth/profile question would otherwise collapse edge-on.

When documenting staged rear-frame construction, use the production state
immediately before the highlighted operation as context rather than the final
completed frame.

## OpenSCAD `use` boundary

`use <...>` imports modules/functions, not file-level variables. Values needed
across files must be exposed through functions or parameters.

Do not create one accessor per view constant; keep one stable view-name-to-ID
conversion path.

## Tooling and publication

Pin `tool.scad-project` under `tools/tool.scad-project` as declared in
`project.yml`. Use thin reusable workflow callers and direct-only submodule
checkout.

Generated build and verification output do not belong on `main`. Branch names
and lifecycle policy are defined in `project.yml`; do not duplicate them here.

Root bootstrap/update scripts are canonical copies from `tool.scad-project` and
must remain Python-free during bootstrap.

## Commit identity

When a normal Git checkout allows explicit authorship, use the configured bot
identity for agent-created commits rather than attributing them to the repository
owner.
