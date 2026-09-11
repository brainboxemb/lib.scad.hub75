use <../hub75_p5_64x32_physical_verification_fixtures.scad>

$fn = 96;
$vpr = [70, 0, 20];

panel = hub75_vrf_default_panel();
hub75_vrf_mounting_spacing_x_gauge(panel);
