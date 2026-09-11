// 1:1 rear-corner verification drawing generated from public HUB75 accessors.
// The left drawing is true-size model geometry. The right table and lower side
// profile explain exactly which nominal values the operator is checking.

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

module _vrf_label(txt, p, size=2.4, halign="left", valign="center", angle=0) {
    translate(p)
        rotate(angle)
            text(txt, size=size, halign=halign, valign=valign);
}

module _vrf_tick(p, angle=45, length=2.0, w=0.22) {
    d = [cos(angle)*length/2, sin(angle)*length/2];
    _vrf_line([p[0]-d[0], p[1]-d[1]], [p[0]+d[0], p[1]+d[1]], w);
}

module _vrf_dim_h(x0, x1, y, label, source_y=0) {
    _vrf_line([x0, source_y], [x0, y+1], 0.16);
    _vrf_line([x1, source_y], [x1, y+1], 0.16);
    _vrf_line([x0, y], [x1, y], 0.22);
    _vrf_tick([x0, y]);
    _vrf_tick([x1, y]);
    _vrf_label(label, [(x0+x1)/2, y+1.5], 1.8, "center");
}

module _vrf_dim_v(y0, y1, x, label, source_x=0) {
    _vrf_line([source_x, y0], [x-1, y0], 0.16);
    _vrf_line([source_x, y1], [x-1, y1], 0.16);
    _vrf_line([x, y0], [x, y1], 0.22);
    _vrf_tick([x, y0]);
    _vrf_tick([x, y1]);
    _vrf_label(label, [x-1.8, (y0+y1)/2], 1.8, "center", "center", 90);
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
reinforcement_recess_depth = hub75_p5_64x32_panel_reinforcement_bushing_recess_depth(panel);
reinforcement_hole_d = hub75_p5_64x32_panel_reinforcement_bushing_hole_diameter(panel);
reinforcement_hole_depth = hub75_p5_64x32_panel_reinforcement_bushing_hole_depth(panel);
inset_x = hub75_p5_64x32_panel_rear_outer_inset_x(panel);
inset_z = hub75_p5_64x32_panel_rear_outer_inset_z(panel);
side_rail = hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel);
end_rail = hub75_p5_64x32_panel_rear_end_rail_width_at_mounting_plane(panel);
opening_x = inset_x + side_rail;
opening_top = inset_z + end_rail;
opening_r = hub75_p5_64x32_panel_rear_opening_corner_radius(panel);
taper_start = hub75_rear_taper_start_y(panel);
reinforcement_edge_extent = hole_x - reinforcement_d/2;
reinforcement_inside_extent = hole_x + reinforcement_d/2;
reinforcement_outer_clip = inset_x - reinforcement_edge_extent;
reinforcement_bay_projection = reinforcement_inside_extent - opening_x;

_vrf_label("HUB75 P5 64x32 - TOP-LEFT REAR VERIFICATION", [-14, 13], 3.2);
_vrf_label("TL-DWG v0.2 / dimensions in mm / left geometry is 1:1", [-14, 9.5], 2.1);

// 1:1 rear-view local corner.
_vrf_line([0, 0], [46, 0], 0.45);
_vrf_line([0, 0], [0, -46], 0.45);
_vrf_label("DATUM A - PHYSICAL TOP EDGE", [23, 1.8], 1.9, "center");
_vrf_label("DATUM B", [-2.0, -30], 1.9, "right");
_vrf_label("PHYSICAL LEFT EDGE", [-2.0, -33], 1.7, "right");

_vrf_line([inset_x, -inset_z], [45, -inset_z], 0.20);
_vrf_line([inset_x, -inset_z], [inset_x, -45], 0.20);

_vrf_ring([hole_x, -hole_top], tube_d, 0.28);
_vrf_ring([hole_x, -hole_top], hole_d, 0.22);
_vrf_line([hole_x-1.5, -hole_top], [hole_x+1.5, -hole_top], 0.16);
_vrf_line([hole_x, -hole_top-1.5], [hole_x, -hole_top+1.5], 0.16);

_vrf_ring([hole_x, -reinforcement_top], reinforcement_d, 0.28);
_vrf_ring([hole_x, -reinforcement_top], reinforcement_recess_d, 0.22);
_vrf_ring([hole_x, -reinforcement_top], reinforcement_hole_d, 0.18);
_vrf_line([hole_x-1.5, -reinforcement_top], [hole_x+1.5, -reinforcement_top], 0.16);
_vrf_line([hole_x, -reinforcement_top-1.5], [hole_x, -reinforcement_top+1.5], 0.16);

arc_c = [opening_x + opening_r, -(opening_top + opening_r)];
_vrf_line([opening_x + opening_r, -opening_top], [46, -opening_top], 0.30);
_vrf_line([opening_x, -(opening_top + opening_r)], [opening_x, -46], 0.30);
_vrf_polyline(_vrf_arc_points(arc_c, opening_r, 90, 180), 0.30);

_vrf_dim_h(0, hole_x, 5.2, str("TL-01  ", _vrf_fmt(hole_x)), 0);
_vrf_dim_v(0, -hole_top, -7.0, str("TL-02  ", _vrf_fmt(hole_top)), 0);
_vrf_dim_v(-hole_top, -reinforcement_top, -13.0, str("TL-06  ", _vrf_fmt(reinforcement_offset)), 0);

_vrf_line([hole_x+tube_d/2, -hole_top], [29, -6.0], 0.16);
_vrf_label(str("TL-03 OD ", _vrf_fmt(tube_d), " / TL-04 HOLE ", _vrf_fmt(hole_d)), [30, -6.0], 1.65);

_vrf_line([hole_x+reinforcement_d/2, -reinforcement_top], [29, -22.0], 0.16);
_vrf_label(
    str("TL-08 OD ", _vrf_fmt(reinforcement_d), " / TL-09 RECESS ", _vrf_fmt(reinforcement_recess_d)),
    [30, -22.0], 1.65
);
_vrf_label(str("TL-11 BLIND HOLE ", _vrf_fmt(reinforcement_hole_d)), [30, -24.7], 1.65);

_vrf_line([opening_x+opening_r*0.3, -(opening_top+opening_r*0.3)], [29, -14.0], 0.16);
_vrf_label(str("CR-02 BAY CORNER R", _vrf_fmt(opening_r)), [30, -14.0], 1.65);

_vrf_label(
    str("REAR PERIMETER  X=", _vrf_fmt(inset_x), "  Z=", _vrf_fmt(inset_z)),
    [3, -34.0], 1.65
);
_vrf_label("CR-01 OUTER CORNER: R0 (VERIFY)", [3, -36.8], 1.55);
_vrf_label(str("RF-01 OUTER CLIP ~= ", _vrf_fmt(reinforcement_outer_clip)), [3, -49.0], 1.65);
_vrf_label(str("RF-02 BAY PROJECTION ~= ", _vrf_fmt(reinforcement_bay_projection)), [3, -52.0], 1.65);

// Nominal-value table, deliberately separated from true-size geometry.
legend_x = 72;
legend_y = 5.5;
legend_step = 3.15;

_vrf_label("NOMINAL VALUES TO CHECK", [legend_x, 9.0], 2.3);
labels = [
    str("TL-01  screw centre from datum B ........ ", _vrf_fmt(hole_x)),
    str("TL-02  screw centre from datum A ........ ", _vrf_fmt(hole_top)),
    str("TL-03  mounting tube OD .................. ", _vrf_fmt(tube_d)),
    str("TL-04  screw through-hole ................ ", _vrf_fmt(hole_d)),
    str("TL-05  tube protrusion .................... ", _vrf_fmt(hub75_p5_64x32_panel_mounting_tube_protrusion(panel))),
    str("TL-06  screw -> reinforcement centre ..... ", _vrf_fmt(reinforcement_offset)),
    str("TL-07  reinforcement from datum A ........ ", _vrf_fmt(reinforcement_top)),
    str("TL-08  reinforcement outer diameter ...... ", _vrf_fmt(reinforcement_d)),
    str("TL-09  reinforcement recess diameter ..... ", _vrf_fmt(reinforcement_recess_d)),
    str("TL-10  reinforcement recess depth ........ ", _vrf_fmt(reinforcement_recess_depth)),
    str("TL-11  reinforcement blind-hole diameter . ", _vrf_fmt(reinforcement_hole_d)),
    str("TL-12  reinforcement blind-hole depth .... ", _vrf_fmt(reinforcement_hole_depth)),
    str("CR-01  rear outside corner ............... R0 CURRENT MODEL"),
    str("CR-02  bay opening corner ................ R", _vrf_fmt(opening_r)),
    str("RF-01  raw reinforcement clipped by wall . ~", _vrf_fmt(reinforcement_outer_clip)),
    str("RF-02  reinforcement projects into bay ... ~", _vrf_fmt(reinforcement_bay_projection))
];

for(i=[0:len(labels)-1])
    _vrf_label(labels[i], [legend_x, legend_y-i*legend_step], 1.65);

profile_origin = [72, -61];
profile_scale = 2.0;
profile_depth = depth * profile_scale;
profile_inset = inset_z * profile_scale;
profile_taper_start = taper_start * profile_scale;

_vrf_label("SIDE PROFILE - TOP OUTER WALL", [profile_origin[0], profile_origin[1]+7], 2.1);
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
_vrf_label(str("TL-15 taper starts Y=", _vrf_fmt(taper_start)), [profile_origin[0], profile_origin[1]-9], 1.65);
_vrf_label(str("TL-13 rear mounting plane Y=", _vrf_fmt(depth)), [profile_origin[0], profile_origin[1]-12], 1.65);
_vrf_label(str("TL-14 rear top inset=", _vrf_fmt(inset_z)), [profile_origin[0], profile_origin[1]-15], 1.65);
