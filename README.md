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
      <a href="../../blob/prod/bld/png/hub75-p5-64x32-panel-front-angled.png">
        <img src="../../raw/prod/bld/png/hub75-p5-64x32-panel-front-angled.png" alt="HUB75 P5 64 x 32 panel front angled view" width="100%">
      </a>
    </td>
    <td align="center">
      <a href="../../blob/prod/bld/png/hub75-p5-64x32-panel-rear-angled.png">
        <img src="../../raw/prod/bld/png/hub75-p5-64x32-panel-rear-angled.png" alt="HUB75 P5 64 x 32 panel rear angled view" width="100%">
      </a>
    </td>
  </tr>
</table>

## Start here

- [Plan](doc/00-plan.md) — work context, sources, current focus and roadmap.
- [Specification](doc/10-specification.md) — why the library exists and what the reference model is intended to mean.
- [Design](doc/20-design.md) — repository/component architecture and responsibility split.
- [Verification](doc/30-verification.md) — functional and physical verification strategy and current physical status.
- [Panel detailed design](openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md) — visual construction of the physical panel model.
- [Panel manual/reference](openscad/p5-64x32-panel/manual.md) — orientation, dimensions, API use and interactive views.
- [Physical verification material](vrf/README.md) — operator procedures, testcases and fixture sources.

Generated output:

- [latest Build](../../tree/prod/bld)
- [latest Verification](../../tree/prod/vrf)
- [generated panel design documentation](../../blob/prod/bld/design/project/openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md)

## Basic use

The library uses OpenSCAD's object model. Create one panel object and pass it to
the build/accessor functions instead of copying dimensions into consumers:

```scad
use <openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>

panel_obj = hub75_p5_64x32_panel_create();

hub75_p5_64x32_panel_build(panel_obj);
width_mm = hub75_p5_64x32_panel_width(panel_obj);
height_mm = hub75_p5_64x32_panel_height(panel_obj);
```

The first component is the portrait-oriented P5 64 × 32 panel reference model.
Its source hierarchy, coordinate system, construction and physical-verification
status are documented through the links above.

Current tooling/runtime versions are intentionally not copied into this README.
Use `project.yml`, `project.scad.yml`, committed gitlinks, live GitHub Actions
and the published `prod/bld` / `prod/vrf` provenance for the exact current
state.

See [CHANGELOG.md](CHANGELOG.md) for release history.
