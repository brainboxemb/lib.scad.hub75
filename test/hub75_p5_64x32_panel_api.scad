use <../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>

panel = hub75_p5_64x32_panel_create();

assert(abs(hub75_p5_64x32_panel_width(panel) - 159.70) < 0.001);
assert(abs(hub75_p5_64x32_panel_height(panel) - 319.71) < 0.001);
assert(abs(hub75_p5_64x32_panel_depth(panel) - 14.50) < 0.001);

assert(len(hub75_p5_64x32_panel_hole_x_positions(panel)) == 2);
assert(len(hub75_p5_64x32_panel_hole_z_positions(panel)) == 3);
assert(abs(hub75_p5_64x32_panel_grid_gap_x(panel) - 0.30) < 0.001);
assert(abs(hub75_p5_64x32_panel_grid_gap_z(panel) - 0.29) < 0.001);

echo("hub75_p5_64x32_panel_width", hub75_p5_64x32_panel_width(panel));
echo("hub75_p5_64x32_panel_height", hub75_p5_64x32_panel_height(panel));
echo("hub75_p5_64x32_panel_rear_grid_gap_x", hub75_p5_64x32_panel_rear_grid_gap_x(panel));

hub75_p5_64x32_panel_build(panel);
