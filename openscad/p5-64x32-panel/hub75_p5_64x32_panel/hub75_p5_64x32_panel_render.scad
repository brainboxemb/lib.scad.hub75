// File: hub75_p5_64x32_panel_render.scad
//   Interactive and generated design-render adapter for the HUB75 P5 64 x 32 panel.
//
// FileSummary: Creates the default panel object and delegates stable named views to the
//   conversion function in hub75_p5_64x32_panel.scad.
//
// The long Customizer enum below is intentional. It makes every documented
// render view directly selectable in OpenSCAD without knowing the source code.

$fn = 64;

use <../hub75_p5_64x32_panel.scad>

/* [Render view] */
render_view = "final"; // [final, front, rear, structure, connectors, verification, profile, physical-envelope, nominal-envelope, grid-gap-x, grid-gap-z, front-mask, front-mask-depth, pcb-layer, pcb-back-plane, front-stack, rear-start-plane, rear-depth, taper-front-footprint, taper-rear-footprint, taper-body, taper-inset-x, taper-inset-z, side-rail-width, end-rail-width, crossbar-width, crossbar-positions, bay-1, bay-2, bay-3, bay-4, bay-rounded-corner, bay-bottom-relief, bay-top-relief, rear-openings, rear-web-solid, rear-web-cut, rear-frame-core, narrow-end-width, narrow-end-length, narrow-transition-left, narrow-transition-right, narrow-profile-complete, recess-side-left, recess-side-right, recess-bottom, recess-top, recess-crossbar-1, recess-crossbar-2, recess-crossbar-3, recess-bushing-protection, rear-recess-2d, rear-recess-3d, rear-after-recess, mounting-column-left, mounting-column-right, mounting-row-bottom, mounting-row-middle, mounting-row-top, mounting-centres, mounting-tube-single, mounting-tubes, mounting-relief-single, mounting-reliefs, mounting-hole-single, mounting-holes, reinforcement-bottom-left, reinforcement-bottom-right, reinforcement-middle-left, reinforcement-middle-right, reinforcement-top-left, reinforcement-top-right, reinforcement-solids, reinforcement-inner-recess, reinforcement-blind-hole, reinforcement-finished, locator-upper-left, locator-lower-right, locator-pins, data-connector-bottom, data-connector-top, data-connectors, power-connector, orientation-bay-1, orientation-bay-2, orientation-bay-4, orientation-all, verification-envelope, verification-mounting, verification-locators, rear-mating-plane, taper-profile, rear-rail-profile, connector-clearance-profile, final-rear, final-profile]

// Module: hub75_p5_64x32_panel_design()
// Usage:
//   hub75_p5_64x32_panel_design("rear-frame-core");
// Description:
//   Creates the default panel object and renders one named documentation view.
module hub75_p5_64x32_panel_design(view = "final") {
    panel = hub75_p5_64x32_panel_create();

    hub75_p5_64x32_panel_render(
        panel,
        view = hub75_p5_64x32_panel_view_id(view)
    );
}

// Interactive OpenSCAD use goes through the Customizer value above.
// Automated design.md rendering can still call the module with its own view.
hub75_p5_64x32_panel_design(render_view);
