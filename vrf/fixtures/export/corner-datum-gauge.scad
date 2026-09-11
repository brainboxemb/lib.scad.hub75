use <../hub75_p5_64x32_physical_verification_fixtures.scad>

$fn = 96;
$vpr = [35, 0, 35];

panel = hub75_vrf_default_panel();
hub75_vrf_corner_datum_gauge(panel);
