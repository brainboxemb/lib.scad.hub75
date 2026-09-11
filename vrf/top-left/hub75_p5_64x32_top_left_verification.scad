// Focused render helpers for the physical upper-left verification procedure.
// These helpers do not duplicate panel geometry: the complete production panel
// is built through the public API and overlays/fixtures consume public accessors.

use <../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../fixtures/hub75_p5_64x32_physical_verification_fixtures.scad>

// "Top-left" always means left as the operator sees the panel from the REAR.
// Looking from the rear mirrors native model X, so visually left is high-X.
function hub75_vrf_top_left_x(panel) =
    hub75_p5_64x32_panel_hole_x_positions_centered(panel)[1];

function hub75_vrf_top_left_z(panel) =
    hub75_p5_64x32_panel_hole_z_positions_centered(panel)[2];

function hub75_vrf_top_left_reinforcement_z(panel) =
    hub75_vrf_top_left_z(panel)
    - hub75_p5_64x32_panel_reinforcement_bushing_offset(panel);

function hub75_vrf_overlay_y(panel) =
    hub75_p5_64x32_panel_depth(panel) + 4.5;

module _hub75_vrf_rear_ring(x, y, z, outer_d, inner_d, thickness=0.7) {
    translate([x, y, z])
        rotate([90, 0, 0])
            difference() {
                cylinder(h=thickness, d=outer_d, center=true, $fn=96);
                cylinder(h=thickness+0.2, d=inner_d, center=true, $fn=96);
            }
}

module _hub75_vrf_rear_rect_frame(x0, x1, z0, z1, y, line=1.2) {
    color([1.0, 0.18, 0.08]) {
        translate([x0, y, z0]) cube([x1-x0, 0.7, line]);
        translate([x0, y, z1-line]) cube([x1-x0, 0.7, line]);
        translate([x0, y, z0]) cube([line, 0.7, z1-z0]);
        translate([x1-line, y, z0]) cube([line, 0.7, z1-z0]);
    }
}

module hub75_vrf_top_left_location(panel, area_width=46, area_height=56) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    rear_left = width/2;
    top = height/2;

    hub75_p5_64x32_panel_build(panel);

    _hub75_vrf_rear_rect_frame(
        rear_left - area_width,
        rear_left,
        top - area_height,
        top,
        hub75_vrf_overlay_y(panel)
    );
}

module hub75_vrf_top_left_feature_map(panel, datum_length=38) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
    reinforcement_d = hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
    x = hub75_vrf_top_left_x(panel);
    z_screw = hub75_vrf_top_left_z(panel);
    z_reinforcement = hub75_vrf_top_left_reinforcement_z(panel);
    rear_left = width/2;
    top = height/2;
    oy = hub75_vrf_overlay_y(panel);

    hub75_p5_64x32_panel_build(panel);

    color([1.0, 0.78, 0.08]) {
        translate([rear_left-datum_length, oy, top-0.5])
            cube([datum_length, 0.7, 1.0]);
        translate([rear_left-0.5, oy, top-datum_length])
            cube([1.0, 0.7, datum_length]);
    }

    color([0.95, 0.12, 0.08])
        _hub75_vrf_rear_ring(
            x, oy+0.5, z_screw,
            tube_d+2.4, tube_d+0.8
        );

    color([0.10, 0.38, 1.0])
        _hub75_vrf_rear_ring(
            x, oy+0.5, z_reinforcement,
            reinforcement_d+2.4, reinforcement_d+0.8
        );
}

// Rear-view detail map for the next physical questions: the bay's concave
// R~5 corner, the separate Ø14 reinforcement footprint, and the sharp rear
// perimeter corner currently implied by the model.
module hub75_vrf_top_left_radius_reinforcement_map(panel) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    inset_x = hub75_p5_64x32_panel_rear_outer_inset_x(panel);
    inset_z = hub75_p5_64x32_panel_rear_outer_inset_z(panel);
    side_rail = hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel);
    end_rail = hub75_p5_64x32_panel_rear_end_rail_width_at_mounting_plane(panel);
    r = hub75_p5_64x32_panel_rear_opening_corner_radius(panel);
    reinforcement_d = hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
    rear_left = width/2;
    top = height/2;
    local_open_x = inset_x + side_rail;
    local_open_z = inset_z + end_rail;
    local_cx = local_open_x + r;
    local_cz = local_open_z + r;
    oy = hub75_vrf_overlay_y(panel);

    hub75_p5_64x32_panel_build(panel);

    // Magenta beads trace the nominal bay-opening radius without obscuring the
    // production edge underneath.
    color([0.95, 0.12, 0.75])
        for(a=[90:6:180]) {
            lx = local_cx + r*cos(a);
            lz = local_cz - r*sin(a);
            gx = rear_left - lx;
            gz = top - lz;
            translate([gx, oy+0.7, gz])
                rotate([90, 0, 0])
                    cylinder(h=0.8, d=0.9, center=true, $fn=24);
        }

    // Blue ring identifies the reinforcement footprint that intrudes into the
    // bay while remaining clipped by the continuous external wall.
    color([0.05, 0.45, 1.0])
        _hub75_vrf_rear_ring(
            hub75_vrf_top_left_x(panel),
            oy+0.8,
            hub75_vrf_top_left_reinforcement_z(panel),
            reinforcement_d+1.8,
            reinforcement_d+0.5
        );

    // Yellow short L marks the current sharp rear-perimeter corner (R0) at the
    // mounting plane. If the real moulding is rounded here, that is new evidence.
    color([1.0, 0.78, 0.08]) {
        translate([rear_left-inset_x-8, oy+0.9, top-inset_z-0.45])
            cube([8, 0.7, 0.9]);
        translate([rear_left-inset_x-0.45, oy+0.9, top-inset_z-8])
            cube([0.9, 0.7, 8]);
    }
}

// Place the print-flat profile comb in its real use orientation.
// Local comb axes: X=front->rear, Y=down from top, Z=print thickness.
// Global panel axes: X=width, Y=front->rear, Z=height.
module hub75_vrf_top_left_profile_comb_on_panel(panel) {
    top = hub75_p5_64x32_panel_height(panel)/2;
    screw_x = hub75_vrf_top_left_x(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
    comb_x = screw_x - tube_d/2 - 2.4;

    multmatrix([
        [0,  0, 1, comb_x],
        [1,  0, 0, 0],
        [0, -1, 0, top],
        [0,  0, 0, 1]
    ])
        hub75_vrf_top_left_profile_comb(panel);
}

module hub75_vrf_top_left_alignment_guide_on_panel(panel) {
    top = hub75_p5_64x32_panel_height(panel)/2;
    screw_x = hub75_vrf_top_left_x(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
    comb_x = screw_x - tube_d/2 - 2.4;

    multmatrix([
        [0,  0, 1, comb_x],
        [1,  0, 0, 0],
        [0, -1, 0, top],
        [0,  0, 0, 1]
    ])
        // SQ1's slot is centred on local Z=0; TL1 occupies Z=0..2 mm.
        translate([0, 0, 1])
            hub75_vrf_top_left_alignment_guide(panel);
}

module hub75_vrf_top_left_comb_use(panel) {
    hub75_p5_64x32_panel_build(panel);

    color([1.0, 0.48, 0.05])
        hub75_vrf_top_left_profile_comb_on_panel(panel);
}

module hub75_vrf_top_left_comb_square_use(panel) {
    hub75_p5_64x32_panel_build(panel);

    color([1.0, 0.48, 0.05])
        hub75_vrf_top_left_profile_comb_on_panel(panel);

    color([0.05, 0.72, 0.82])
        hub75_vrf_top_left_alignment_guide_on_panel(panel);
}
