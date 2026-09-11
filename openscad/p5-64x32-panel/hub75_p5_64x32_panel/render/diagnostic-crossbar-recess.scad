// Temporary diagnostic: middle crossbar recess with the production rear-preview camera.
use <../../hub75_p5_64x32_panel.scad>

$fn = 120;
$vpr = [90, 0, 205];

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_render(
    panel,
    hub75_p5_64x32_panel_view_id("recess-crossbar-2")
);
