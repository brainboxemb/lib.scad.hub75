// Temporary diagnostic: middle crossbar before the shallow rear-face recess.
use <../../hub75_p5_64x32_panel.scad>

$fn = 120;
$vpr = [90, 0, 180];
$vpt = [0, 10, 0];
$vpd = 125;

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_render(
    panel,
    hub75_p5_64x32_panel_view_id("rear-frame-core")
);
