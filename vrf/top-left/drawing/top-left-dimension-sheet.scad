// 1:1 rear-corner verification drawing generated from public HUB75 accessors.

use <../../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>

panel = hub75_p5_64x32_panel_create();
$fn = 96;

function _vrf_fmt(v) = str(round(v*1000)/1000);
function _vrf_arc_points(c, r, a0, a1, step=5) =
    [for(a=[a0:step:a1]) [c[0] + r*cos(a), c[1] + r*sin(a)]];

module _vrf_line(p0, p1, w=0.25) {
    hull() {
        translate(p0) circle(d=w);
        translate(p1) circle(d=w);
    }
}

module _vrf_polyline(points, w=0.25) {
    for(i=[0:len(points)-2])
        _vrf_line(points[i], points[i+1], w);
}

module _vrf_ring(c, d, w=0.25) {
    translate(c)
        difference() {
            circle(d=d+w);
            circle(d=max(0.01, d-w));
        }
}

module _vrf_label(txt, p, size=2.4, halign="left") {
    translate(p)
        text(txt, size=size, halign=halign, valign="center");
}

width = hub75_p5_64x32_panel_width(panel);
height = hub75_p5_64x32_panel_height(panel);
depth = hub75_p5_64x32_panel_depth(panel);
hole_x = hub75_p5_64x32_panel_hole_x_positions(panel)[0];
hole_top = height - hub75_p5_64x32_panel_hole_z_positions(panel)[2];
tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
hole_d = hub75_p5_64x32_panel_hole_diameter(panel);
reinforcement_offset = hub75_p5_64x32_panel_reinforcement_bushing_offset(panel);
reinforcement_top = hole_top + reinforcement_offset;
reinforcement_d = hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
reinforcement_recess_d = hub75_p5_64x32_panel_reinforcement_bushing_recess_diameter(panel);
reinforcement_hole_d = hub75_p5_64x32_panel_reinforcement_bushing_hole_diameter(panel);
inset_x = hub75_p5_64x32_panel_rear_outer_inset_x(panel);
inset_z = hub75_p5_64x32_panel_rear_outer_inset_z(panel);
side_rail = hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel);
end_rail = hub75_p5_64x32_panel_rear_end_rail_width_at_mounting_plane(panel);
opening_x = inset_x + side_rail;
opening_top = inset_z + end_rail;
opening_r = hub75_p5_64x32_panel_rear_opening_corner_radius(panel);
taper_start = hub75_rear_taper_start_y(panel);

// -----------------------------------------------------------------------------
// Rear-view local corner: X = inward from rear-view left physical edge,
// Y = downward from physical top edge (drawn negative on this sheet).
// -----------------------------------------------------------------------------

_vrf_label("HUB75 P5 64x32 - TOP-LEFT REAR VERIFICATION", [0, 7], 3.2);
_vrf_label("TL-DWG v0.1  /  dimensions in mm  /  1:1 geometry", [0, 3.5], 2.2);

// Datum A/B physical edges.
_vrf_line([0, 0], [46, 0], 0.45);
_vrf_line([0, 0], [0, -46], 0.45);
_vrf_label("DATUM A - physical top edge", [20, 1.7], 2.0, "center");
_vrf_label("DATUM B", [-1.5, -22], 2.0, "right");
_vrf_label("physical left edge", [-1.5, -25], 1.8, "right");

// Rear perimeter is inset from the physical front envelope and is currently
// modelled with a sharp X/Z corner (R0). This is a real verification question.
_vrf_line([inset_x, -inset_z], [45, -inset_z], 0.22);
_vrf_line([inset_x, -inset_z], [inset_x, -45], 0.22);
_vrf_label(str("rear perimeter inset X ", _vrf_fmt(inset_x)), [25, -3.7], 1.8);
_vrf_label(str("rear perimeter inset Z ", _vrf_fmt(inset_z)), [25, -6.2], 1.8);
_vrf_label("outer rear corner: current model R0 - VERIFY", [25, -8.7], 1.8);

// Mounting tube / through-hole.
_vrf_ring([hole_x, -hole_top], tube_d, 0.28);
_vrf_ring([hole_x, -hole_top], hole_d, 0.22);
_vrf_line([hole_x-1.5, -hole_top], [hole_x+1.5, -hole_top], 0.16);
_vrf_line([hole_x, -hole_top-1.5], [hole_x, -hole_top+1.5], 0.16);

// Reinforcement footprint and nested recess/hole.
_vrf_ring([hole_x, -reinforcement_top], reinforcement_d, 0.28);
_vrf_ring([hole_x, -reinforcement_top], reinforcement_recess_d, 0.22);
_vrf_ring([hole_x, -reinforcement_top], reinforcement_hole_d, 0.18);
_vrf_line([hole_x-1.5, -reinforcement_top], [hole_x+1.5, -reinforcement_top], 0.16);
_vrf_line([hole_x, -reinforcement_top-1.5], [hole_x, -reinforcement_top+1.5], 0.16);

// Nominal top-left corner of the upper rear bay opening.
arc_c = [opening_x + opening_r, -(opening_top + opening_r)];
_vrf_line([opening_x + opening_r, -opening_top], [45, -opening_top], 0.30);
_vrf_line([opening_x, -(opening_top + opening_r)], [opening_x, -45], 0.30);
_vrf_polyline(_vrf_arc_points(arc_c, opening_r, 90, 180), 0.30);
_vrf_label(str("bay opening R ", _vrf_fmt(opening_r)), [25, -12.0], 1.9);
_vrf_label(str("bay edge from left ", _vrf_fmt(opening_x)), [25, -14.5], 1.8);
_vrf_label(str("bay edge from top ", _vrf_fmt(opening_top)), [25, -17.0], 1.8);

// Dimension/value legend. The geometry at left remains 1:1; this legend names
// exactly what should be recorded during the physical session.
legend_x = 52;
legend_y = 0;
legend_step = 3.4;
labels = [
    str("TL-01 screw X from datum B = ", _vrf_fmt(hole_x)),
    str("TL-02 screw Z from datum A = ", _vrf_fmt(hole_top)),
    str("TL-03 mounting tube OD = ", _vrf_fmt(tube_d)),
    str("TL-04 through hole = ", _vrf_fmt(hole_d)),
    str("TL-06 reinforcement offset = ", _vrf_fmt(reinforcement_offset)),
    str("TL-07 reinforcement from top = ", _vrf_fmt(reinforcement_top)),
    str("TL-08 reinforcement OD = ", _vrf_fmt(reinforcement_d)),
    str("TL-09 reinforcement recess = ", _vrf_fmt(reinforcement_recess_d)),
    str("TL-11 reinforcement blind hole = ", _vrf_fmt(reinforcement_hole_d)),
    str("bay opening corner = R", _vrf_fmt(opening_r)),
    "rear outer X/Z corner = R0 in current model"
];

for(i=[0:len(labels)-1])
    _vrf_label(labels[i], [legend_x, legend_y-i*legend_step], 2.0);

// -----------------------------------------------------------------------------
// Side/profile inset below the rear-view drawing.
// -----------------------------------------------------------------------------
profile_origin = [52, -47];
profile_scale = 2.0;
profile_depth = depth * profile_scale;
profile_inset = inset_z * profile_scale;
profile_taper_start = taper_start * profile_scale;

_vrf_label("SIDE PROFILE - top outer wall", [profile_origin[0], profile_origin[1]+6], 2.2);
_vrf_line(profile_origin, [profile_origin[0]+profile_taper_start, profile_origin[1]], 0.35);
_vrf_line(
    [profile_origin[0]+profile_taper_start, profile_origin[1]],
    [profile_origin[0]+profile_depth, profile_origin[1]-profile_inset],
    0.35
);
_vrf_line(
    [profile_origin[0], profile_origin[1]-6],
    [profile_origin[0]+profile_depth, profile_origin[1]-6],
    0.18
);
_vrf_label(str("front -> taper start ", _vrf_fmt(taper_start)), [profile_origin[0], profile_origin[1]-9], 1.8);
_vrf_label(str("rear mounting plane Y ", _vrf_fmt(depth)), [profile_origin[0], profile_origin[1]-12], 1.8);
_vrf_label(str("rear top inset ", _vrf_fmt(inset_z)), [profile_origin[0], profile_origin[1]-15], 1.8);
