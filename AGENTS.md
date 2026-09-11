# Repository agent guidance

Persistent guidance for automated coding agents working in `lib.scad.hub75`.

## Generic workflow policy

Before branch, pull-request, publication or release work, read the pinned
`tools/tool.scad-project/AGENTS.md`. Its pull-request-first change workflow and
publication lifecycle are authoritative for this consumer.

This root file adds HUB75-library-specific guidance only. It must not contradict
or duplicate changing generic branch/PR/publication rules from the pinned tool
policy.

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
checkout. Generic branch naming, pull-request previews, cleanup and release
lifecycle are governed by the pinned tool policy.

Generated build and verification output do not belong on `main`.

Root bootstrap/update scripts are canonical copies from `tool.scad-project` and
must remain Python-free during bootstrap.

## Commit identity

When a normal Git checkout allows explicit authorship, use the configured bot
identity for agent-created commits rather than attributing them to the repository
owner.
