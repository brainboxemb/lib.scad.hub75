// Temporary diagnostic: rear frame core viewed from the true rear side.
use <../../hub75_p5_64x32_panel.scad>

$fn = 120;
$vpr = [90, 0, 180];

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_render(
    panel,
    hub75_p5_64x32_panel_view_id("rear-frame-core")
);
