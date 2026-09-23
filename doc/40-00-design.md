# HUB75 library design

This document describes the **repository-level architecture** used to realise
the intent in [30-00-specification.md](30-00-specification.md).

## Repository decomposition

The current panel family is organised as:

```text
openscad/p5-64x32-panel/
├── hub75_p5_64x32_panel.scad        public/production model + API
├── manual.md                        usage/reference/API guidance
└── hub75_p5_64x32_panel/
    ├── hub75_p5_64x32_panel_render.scad
    ├── design/
    │   └── design.md                detailed visual construction
    └── render/
        └── ...                      presentation render entrypoints

test/
    software/API regression

vrf/
    physical procedures, testcase sources, fixtures and evidence-generation sources
```

The component-local design is intentionally retained: physical construction is
easier to understand beside its production geometry and named design views than
as a large repository-level detailed-design chapter.

## Public model and object ownership

`hub75_p5_64x32_panel.scad` owns the production geometry and public object/API.
A consumer creates one panel object and passes it to build/accessor functions.

Private implementation helpers remain private to the component. Documentation
and render adapters reuse production helpers rather than implementing a second
approximate panel model.

## Detailed visual design

The component
[design/design.md](../openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md)
is the detailed design for the physical panel construction.

It explains staged geometry with stable named views and generated figures. It is
not replaced by this repository-level architecture document.

The sibling render adapter maps those stable view names to the real production
geometry. Presentation-only colors/cameras may differ; geometry must not.

## Manual/reference role

[manual.md](../openscad/p5-64x32-panel/manual.md) explains how consumers use the
model: native orientation, physical versus nominal placement dimensions, public
object/accessors, interactive views and source authority.

## Coordinate and view model

The production component keeps one native XYZ coordinate system and one stable
view-name/ID table. Render/design adapters select named views through that same
table so documentation and debugging do not maintain separate view semantics.

## Build and verification split

Repository tooling declares three visible SCAD capabilities:

- `scad.docs` — generated component design documentation;
- `scad.build` — presentation renders;
- `scad.verify` — software/API verification plus physical-verification fixtures/plan output.

The exact current tooling/runtime is configuration and provenance, not design
knowledge. Read `project.yml`, `project.scad.yml`, the committed gitlinks and
live publication evidence for that state.

## Physical verification structure

[50-00-verification.md](50-00-verification.md) owns the repository-level verification
strategy and current physical-verification status.

`vrf/` owns executable material: operator procedures, physical testcase files,
fixture geometry, verification render sources and generated-output assembly.

This keeps 'why/how do we prove it?' separate from the workbench procedure itself.
