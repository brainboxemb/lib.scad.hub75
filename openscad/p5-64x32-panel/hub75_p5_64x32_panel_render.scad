// File: hub75_p5_64x32_panel_render.scad
//   Design-render adapter for the HUB75 P5 64 x 32 panel reference component.
//
// FileSummary: Creates the default panel object and delegates stable named views to the
//   conversion function in hub75_p5_64x32_panel.scad.
//
// This file deliberately contains no view table, numeric IDs or panel geometry.

$fn = 64;

use <hub75_p5_64x32_panel.scad>

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

hub75_p5_64x32_panel_design();
