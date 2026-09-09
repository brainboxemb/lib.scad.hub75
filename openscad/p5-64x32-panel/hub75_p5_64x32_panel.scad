// File: hub75_p5_64x32_panel.scad
//   Reusable reference model for a HUB75 P5 64 x 32 LED matrix panel.
//
// FileSummary: Object-based HUB75 panel specification, geometry and design views.
//
// Geometry references recorded by the supplied source model:
// - supplied STEP model: Hub75 P5 Matrix Panel.step
// - supplied dimensional drawing: 2277_P5_320x160mm_64x32+pixel.pdf
// - supplied rear-panel photograph as secondary visual reference
//
// Coordinate system:
// - X = panel width, centred around X = 0
// - Y = front to rear, with front face at Y = 0
// - Z = panel height, centred around Z = 0
//
// The public API is object based. Consumers create one panel specification and
// pass that object to build/accessor functions. Physical dimensions are not
// duplicated as unrelated project constants.

$fn = 48;

// All render/design views share one sequential numeric ID space.
//
// The constant value intentionally equals the row index in VIEW_TABLE.
// Keeping the constant in column 0 is deliberate duplication: it gives us
// a cheap C-style consistency check whenever a view is requested.
HUB75_P5_64X32_PANEL_VIEW_FINAL = 0;
HUB75_P5_64X32_PANEL_VIEW_FRONT = 1;
HUB75_P5_64X32_PANEL_VIEW_REAR = 2;
HUB75_P5_64X32_PANEL_VIEW_STRUCTURE = 3;
HUB75_P5_64X32_PANEL_VIEW_CONNECTORS = 4;
HUB75_P5_64X32_PANEL_VIEW_VERIFICATION = 5;
HUB75_P5_64X32_PANEL_VIEW_PROFILE = 6;
HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE = 7;
HUB75_P5_64X32_PANEL_VIEW_NOMINAL_ENVELOPE = 8;
HUB75_P5_64X32_PANEL_VIEW_GRID_GAP_X = 9;
HUB75_P5_64X32_PANEL_VIEW_GRID_GAP_Z = 10;
HUB75_P5_64X32_PANEL_VIEW_FRONT_MASK = 11;
HUB75_P5_64X32_PANEL_VIEW_FRONT_MASK_DEPTH = 12;
HUB75_P5_64X32_PANEL_VIEW_PCB_LAYER = 13;
HUB75_P5_64X32_PANEL_VIEW_PCB_BACK_PLANE = 14;
HUB75_P5_64X32_PANEL_VIEW_FRONT_STACK = 15;
HUB75_P5_64X32_PANEL_VIEW_REAR_START_PLANE = 16;
HUB75_P5_64X32_PANEL_VIEW_REAR_DEPTH = 17;
HUB75_P5_64X32_PANEL_VIEW_TAPER_FRONT_FOOTPRINT = 18;
HUB75_P5_64X32_PANEL_VIEW_TAPER_REAR_FOOTPRINT = 19;
HUB75_P5_64X32_PANEL_VIEW_TAPER_BODY = 20;
HUB75_P5_64X32_PANEL_VIEW_TAPER_INSET_X = 21;
HUB75_P5_64X32_PANEL_VIEW_TAPER_INSET_Z = 22;
HUB75_P5_64X32_PANEL_VIEW_SIDE_RAIL_WIDTH = 23;
HUB75_P5_64X32_PANEL_VIEW_END_RAIL_WIDTH = 24;
HUB75_P5_64X32_PANEL_VIEW_CROSSBAR_WIDTH = 25;
HUB75_P5_64X32_PANEL_VIEW_CROSSBAR_POSITIONS = 26;
HUB75_P5_64X32_PANEL_VIEW_BAY_1 = 27;
HUB75_P5_64X32_PANEL_VIEW_BAY_2 = 28;
HUB75_P5_64X32_PANEL_VIEW_BAY_3 = 29;
HUB75_P5_64X32_PANEL_VIEW_BAY_4 = 30;
HUB75_P5_64X32_PANEL_VIEW_BAY_ROUNDED_CORNER = 31;
HUB75_P5_64X32_PANEL_VIEW_BAY_BOTTOM_RELIEF = 32;
HUB75_P5_64X32_PANEL_VIEW_BAY_TOP_RELIEF = 33;
HUB75_P5_64X32_PANEL_VIEW_REAR_OPENINGS = 34;
HUB75_P5_64X32_PANEL_VIEW_REAR_WEB_SOLID = 35;
HUB75_P5_64X32_PANEL_VIEW_REAR_WEB_CUT = 36;
HUB75_P5_64X32_PANEL_VIEW_REAR_FRAME_CORE = 37;
HUB75_P5_64X32_PANEL_VIEW_NARROW_END_WIDTH = 38;
HUB75_P5_64X32_PANEL_VIEW_NARROW_END_LENGTH = 39;
HUB75_P5_64X32_PANEL_VIEW_NARROW_TRANSITION_LEFT = 40;
HUB75_P5_64X32_PANEL_VIEW_NARROW_TRANSITION_RIGHT = 41;
HUB75_P5_64X32_PANEL_VIEW_NARROW_PROFILE_COMPLETE = 42;
HUB75_P5_64X32_PANEL_VIEW_RECESS_SIDE_LEFT = 43;
HUB75_P5_64X32_PANEL_VIEW_RECESS_SIDE_RIGHT = 44;
HUB75_P5_64X32_PANEL_VIEW_RECESS_BOTTOM = 45;
HUB75_P5_64X32_PANEL_VIEW_RECESS_TOP = 46;
HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_1 = 47;
HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_2 = 48;
HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_3 = 49;
HUB75_P5_64X32_PANEL_VIEW_RECESS_BUSHING_PROTECTION = 50;
HUB75_P5_64X32_PANEL_VIEW_REAR_RECESS_2D = 51;
HUB75_P5_64X32_PANEL_VIEW_REAR_RECESS_3D = 52;
HUB75_P5_64X32_PANEL_VIEW_REAR_AFTER_RECESS = 53;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_COLUMN_LEFT = 54;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_COLUMN_RIGHT = 55;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_BOTTOM = 56;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_MIDDLE = 57;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_TOP = 58;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_CENTRES = 59;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBE_SINGLE = 60;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBES = 61;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_RELIEF_SINGLE = 62;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_RELIEFS = 63;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_HOLE_SINGLE = 64;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_HOLES = 65;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BOTTOM_LEFT = 66;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BOTTOM_RIGHT = 67;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_MIDDLE_LEFT = 68;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_MIDDLE_RIGHT = 69;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_TOP_LEFT = 70;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_TOP_RIGHT = 71;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_SOLIDS = 72;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_INNER_RECESS = 73;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BLIND_HOLE = 74;
HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_FINISHED = 75;
HUB75_P5_64X32_PANEL_VIEW_LOCATOR_UPPER_LEFT = 76;
HUB75_P5_64X32_PANEL_VIEW_LOCATOR_LOWER_RIGHT = 77;
HUB75_P5_64X32_PANEL_VIEW_LOCATOR_PINS = 78;
HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTOR_BOTTOM = 79;
HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTOR_TOP = 80;
HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTORS = 81;
HUB75_P5_64X32_PANEL_VIEW_POWER_CONNECTOR = 82;
HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_1 = 83;
HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_2 = 84;
HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_4 = 85;
HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_ALL = 86;
HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_ENVELOPE = 87;
HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_MOUNTING = 88;
HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_LOCATORS = 89;
HUB75_P5_64X32_PANEL_VIEW_REAR_MATING_PLANE = 90;
HUB75_P5_64X32_PANEL_VIEW_TAPER_PROFILE = 91;
HUB75_P5_64X32_PANEL_VIEW_REAR_RAIL_PROFILE = 92;
HUB75_P5_64X32_PANEL_VIEW_CONNECTOR_CLEARANCE_PROFILE = 93;
HUB75_P5_64X32_PANEL_VIEW_FINAL_REAR = 94;
HUB75_P5_64X32_PANEL_VIEW_FINAL_PROFILE = 95;

HUB75_P5_64X32_PANEL_VIEW_TABLE = [
    [HUB75_P5_64X32_PANEL_VIEW_FINAL, "final"],
    [HUB75_P5_64X32_PANEL_VIEW_FRONT, "front"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR, "rear"],
    [HUB75_P5_64X32_PANEL_VIEW_STRUCTURE, "structure"],
    [HUB75_P5_64X32_PANEL_VIEW_CONNECTORS, "connectors"],
    [HUB75_P5_64X32_PANEL_VIEW_VERIFICATION, "verification"],
    [HUB75_P5_64X32_PANEL_VIEW_PROFILE, "profile"],
    [HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE, "physical-envelope"],
    [HUB75_P5_64X32_PANEL_VIEW_NOMINAL_ENVELOPE, "nominal-envelope"],
    [HUB75_P5_64X32_PANEL_VIEW_GRID_GAP_X, "grid-gap-x"],
    [HUB75_P5_64X32_PANEL_VIEW_GRID_GAP_Z, "grid-gap-z"],
    [HUB75_P5_64X32_PANEL_VIEW_FRONT_MASK, "front-mask"],
    [HUB75_P5_64X32_PANEL_VIEW_FRONT_MASK_DEPTH, "front-mask-depth"],
    [HUB75_P5_64X32_PANEL_VIEW_PCB_LAYER, "pcb-layer"],
    [HUB75_P5_64X32_PANEL_VIEW_PCB_BACK_PLANE, "pcb-back-plane"],
    [HUB75_P5_64X32_PANEL_VIEW_FRONT_STACK, "front-stack"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_START_PLANE, "rear-start-plane"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_DEPTH, "rear-depth"],
    [HUB75_P5_64X32_PANEL_VIEW_TAPER_FRONT_FOOTPRINT, "taper-front-footprint"],
    [HUB75_P5_64X32_PANEL_VIEW_TAPER_REAR_FOOTPRINT, "taper-rear-footprint"],
    [HUB75_P5_64X32_PANEL_VIEW_TAPER_BODY, "taper-body"],
    [HUB75_P5_64X32_PANEL_VIEW_TAPER_INSET_X, "taper-inset-x"],
    [HUB75_P5_64X32_PANEL_VIEW_TAPER_INSET_Z, "taper-inset-z"],
    [HUB75_P5_64X32_PANEL_VIEW_SIDE_RAIL_WIDTH, "side-rail-width"],
    [HUB75_P5_64X32_PANEL_VIEW_END_RAIL_WIDTH, "end-rail-width"],
    [HUB75_P5_64X32_PANEL_VIEW_CROSSBAR_WIDTH, "crossbar-width"],
    [HUB75_P5_64X32_PANEL_VIEW_CROSSBAR_POSITIONS, "crossbar-positions"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_1, "bay-1"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_2, "bay-2"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_3, "bay-3"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_4, "bay-4"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_ROUNDED_CORNER, "bay-rounded-corner"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_BOTTOM_RELIEF, "bay-bottom-relief"],
    [HUB75_P5_64X32_PANEL_VIEW_BAY_TOP_RELIEF, "bay-top-relief"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_OPENINGS, "rear-openings"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_WEB_SOLID, "rear-web-solid"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_WEB_CUT, "rear-web-cut"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_FRAME_CORE, "rear-frame-core"],
    [HUB75_P5_64X32_PANEL_VIEW_NARROW_END_WIDTH, "narrow-end-width"],
    [HUB75_P5_64X32_PANEL_VIEW_NARROW_END_LENGTH, "narrow-end-length"],
    [HUB75_P5_64X32_PANEL_VIEW_NARROW_TRANSITION_LEFT, "narrow-transition-left"],
    [HUB75_P5_64X32_PANEL_VIEW_NARROW_TRANSITION_RIGHT, "narrow-transition-right"],
    [HUB75_P5_64X32_PANEL_VIEW_NARROW_PROFILE_COMPLETE, "narrow-profile-complete"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_SIDE_LEFT, "recess-side-left"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_SIDE_RIGHT, "recess-side-right"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_BOTTOM, "recess-bottom"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_TOP, "recess-top"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_1, "recess-crossbar-1"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_2, "recess-crossbar-2"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_3, "recess-crossbar-3"],
    [HUB75_P5_64X32_PANEL_VIEW_RECESS_BUSHING_PROTECTION, "recess-bushing-protection"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_RECESS_2D, "rear-recess-2d"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_RECESS_3D, "rear-recess-3d"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_AFTER_RECESS, "rear-after-recess"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_COLUMN_LEFT, "mounting-column-left"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_COLUMN_RIGHT, "mounting-column-right"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_BOTTOM, "mounting-row-bottom"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_MIDDLE, "mounting-row-middle"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_TOP, "mounting-row-top"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_CENTRES, "mounting-centres"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBE_SINGLE, "mounting-tube-single"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBES, "mounting-tubes"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_RELIEF_SINGLE, "mounting-relief-single"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_RELIEFS, "mounting-reliefs"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_HOLE_SINGLE, "mounting-hole-single"],
    [HUB75_P5_64X32_PANEL_VIEW_MOUNTING_HOLES, "mounting-holes"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BOTTOM_LEFT, "reinforcement-bottom-left"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BOTTOM_RIGHT, "reinforcement-bottom-right"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_MIDDLE_LEFT, "reinforcement-middle-left"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_MIDDLE_RIGHT, "reinforcement-middle-right"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_TOP_LEFT, "reinforcement-top-left"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_TOP_RIGHT, "reinforcement-top-right"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_SOLIDS, "reinforcement-solids"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_INNER_RECESS, "reinforcement-inner-recess"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BLIND_HOLE, "reinforcement-blind-hole"],
    [HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_FINISHED, "reinforcement-finished"],
    [HUB75_P5_64X32_PANEL_VIEW_LOCATOR_UPPER_LEFT, "locator-upper-left"],
    [HUB75_P5_64X32_PANEL_VIEW_LOCATOR_LOWER_RIGHT, "locator-lower-right"],
    [HUB75_P5_64X32_PANEL_VIEW_LOCATOR_PINS, "locator-pins"],
    [HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTOR_BOTTOM, "data-connector-bottom"],
    [HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTOR_TOP, "data-connector-top"],
    [HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTORS, "data-connectors"],
    [HUB75_P5_64X32_PANEL_VIEW_POWER_CONNECTOR, "power-connector"],
    [HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_1, "orientation-bay-1"],
    [HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_2, "orientation-bay-2"],
    [HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_4, "orientation-bay-4"],
    [HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_ALL, "orientation-all"],
    [HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_ENVELOPE, "verification-envelope"],
    [HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_MOUNTING, "verification-mounting"],
    [HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_LOCATORS, "verification-locators"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_MATING_PLANE, "rear-mating-plane"],
    [HUB75_P5_64X32_PANEL_VIEW_TAPER_PROFILE, "taper-profile"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR_RAIL_PROFILE, "rear-rail-profile"],
    [HUB75_P5_64X32_PANEL_VIEW_CONNECTOR_CLEARANCE_PROFILE, "connector-clearance-profile"],
    [HUB75_P5_64X32_PANEL_VIEW_FINAL_REAR, "final-rear"],
    [HUB75_P5_64X32_PANEL_VIEW_FINAL_PROFILE, "final-profile"]
];

// Private name lookup used by the documentation/render adapter.
function _hub75_p5_64x32_panel_view_index(name, index = 0) =
    index >= len(HUB75_P5_64X32_PANEL_VIEW_TABLE)
        ? -1
        : HUB75_P5_64X32_PANEL_VIEW_TABLE[index][1] == name
            ? index
            : _hub75_p5_64x32_panel_view_index(name, index + 1);

// Function: hub75_p5_64x32_panel_view_entry()
// Description:
//   Returns one table row and checks the intentional index == constant rule.
function hub75_p5_64x32_panel_view_entry(view) =
    assert(
        view >= 0 && view < len(HUB75_P5_64X32_PANEL_VIEW_TABLE),
        str("Unknown HUB75 panel view ID: ", view)
    )
    assert(
        HUB75_P5_64X32_PANEL_VIEW_TABLE[view][0] == view,
        str(
            "HUB75 panel view table mismatch at index ", view,
            ": row contains ID ",
            HUB75_P5_64X32_PANEL_VIEW_TABLE[view][0]
        )
    )
    HUB75_P5_64X32_PANEL_VIEW_TABLE[view];

// Function: hub75_p5_64x32_panel_view_id()
// Usage:
//   view_id = hub75_p5_64x32_panel_view_id("rear-frame-core");
// Description:
//   Converts a stable named view into its numeric ID using VIEW_TABLE.
//   The returned row is validated through hub75_p5_64x32_panel_view_entry().
function hub75_p5_64x32_panel_view_id(name) =
    let(index = _hub75_p5_64x32_panel_view_index(name))
    assert(index >= 0, str("Unknown HUB75 panel view: ", name))
    hub75_p5_64x32_panel_view_entry(index)[0];

// Function: hub75_p5_64x32_panel_view_name()
// Description:
//   Returns the stable name for a numeric view ID.
function hub75_p5_64x32_panel_view_name(view) =
    hub75_p5_64x32_panel_view_entry(view)[1];




// Function: hub75_p5_64x32_panel_create()
// Usage:
//   panel = hub75_p5_64x32_panel_create();
// Description:
//   Creates the public HUB75 panel specification object. The defaults preserve
//   the dimensions from the supplied source model.
// Arguments:
//   width = Physical panel width in portrait orientation.
//   height = Physical panel height in portrait orientation.
//   depth = Overall front-to-rear panel depth.
//   reference_width = Nominal placement-grid width.
//   reference_height = Nominal placement-grid height.
function hub75_p5_64x32_panel_create(
    width = 159.70,
    height = 319.71,
    depth = 14.50,
    reference_width = 160.00,
    reference_height = 320.00,
    front_mask_depth = 1.00,
    pcb_thickness = 1.00,
    rear_recess_depth = 0.80,
    rear_outer_inset = 1.25,
    hole_x_left = 7.85,
    hole_x_right = 151.85,
    hole_z_bottom = 7.855,
    hole_z_middle = 159.855,
    hole_z_top = 311.855,
    hole_diameter = 3.00,
    mounting_tube_outer_diameter = 8.50,
    mounting_tube_protrusion = 0.50,
    mounting_tube_relief_clearance = 0.75,
    mounting_tube_relief_depth = 0.80,
    reinforcement_bushing_outer_diameter = 14.0,
    reinforcement_bushing_inner_diameter = 10.0,
    reinforcement_bushing_protrusion = 0.00,
    reinforcement_bushing_inner_recess = 2.50,
    reinforcement_bushing_hole_diameter = 2.50,
    reinforcement_bushing_hole_depth = 10.00,
    reinforcement_disc_offset = 11.0,
    locator_pin_diameter = 3.00,
    locator_pin_protrusion = 3.00,
    locator_pin_landscape_x_offset = 110.00,
    locator_pin_landscape_y_offset = 75.00,
    rear_frame_side_width_reference = 12.5,
    rear_frame_end_width_reference = 10.75,
    rear_frame_end_narrow_width_reference = 7.75,
    rear_frame_end_narrow_length_reference = 30.0,
    rear_frame_crossbar_width_reference = 20.0,
    rear_crossbar_1_reference = 80.0,
    rear_crossbar_2_reference = 160.0,
    rear_crossbar_3_reference = 240.0,
    rear_opening_corner_radius_reference = 5.0,
    rear_side_recess_margin_reference = 2.0,
    rear_end_recess_margin_reference = 2.0,
    rear_crossbar_recess_margin_reference = 1.5,
    rear_recess_corner_radius_reference = 0.8,
    data_connector_depth = 10.64,
    data_connector_front_y = 2.63,
    power_connector_x_reference = 53.0,
    power_connector_z_reference = 128.0,
    power_connector_width = 13.0,
    power_connector_height = 20.0,
    power_connector_depth = 7.0

) =
    assert(width > 0, "width must be > 0")
    assert(height > 0, "height must be > 0")
    assert(depth > 0, "depth must be > 0")
    assert(front_mask_depth >= 0, "front_mask_depth must be >= 0")
    assert(pcb_thickness >= 0, "pcb_thickness must be >= 0")
    assert(front_mask_depth + pcb_thickness < depth,
        "front layers must be shallower than the total depth")
    assert(hole_diameter > 0, "hole_diameter must be > 0")
    object(
        width = width,
        height = height,
        depth = depth,
        reference_width = reference_width,
        reference_height = reference_height,
        front_mask_depth = front_mask_depth,
        pcb_thickness = pcb_thickness,
        mounting_plane_y = depth,
        max_depth = depth,
        rear_recess_depth = rear_recess_depth,
        rear_outer_inset = rear_outer_inset,
        hole_x_left = hole_x_left,
        hole_x_right = hole_x_right,
        hole_z_bottom = hole_z_bottom,
        hole_z_middle = hole_z_middle,
        hole_z_top = hole_z_top,
        hole_diameter = hole_diameter,
        mounting_tube_outer_diameter = mounting_tube_outer_diameter,
        mounting_tube_protrusion = mounting_tube_protrusion,
        mounting_tube_relief_clearance = mounting_tube_relief_clearance,
        mounting_tube_relief_depth = mounting_tube_relief_depth,
        reinforcement_bushing_outer_diameter = reinforcement_bushing_outer_diameter,
        reinforcement_bushing_inner_diameter = reinforcement_bushing_inner_diameter,
        reinforcement_bushing_protrusion = reinforcement_bushing_protrusion,
        reinforcement_bushing_inner_recess = reinforcement_bushing_inner_recess,
        reinforcement_bushing_hole_diameter = reinforcement_bushing_hole_diameter,
        reinforcement_bushing_hole_depth = reinforcement_bushing_hole_depth,
        reinforcement_bushing_inner_depth =
            reinforcement_bushing_inner_recess + reinforcement_bushing_hole_depth,
        reinforcement_disc_offset = reinforcement_disc_offset,
        locator_pin_diameter = locator_pin_diameter,
        locator_pin_protrusion = locator_pin_protrusion,
        locator_pin_landscape_x_offset = locator_pin_landscape_x_offset,
        locator_pin_landscape_y_offset = locator_pin_landscape_y_offset,
        rear_frame_side_width_reference = rear_frame_side_width_reference,
        rear_frame_end_width_reference = rear_frame_end_width_reference,
        rear_frame_end_narrow_width_reference = rear_frame_end_narrow_width_reference,
        rear_frame_end_narrow_length_reference = rear_frame_end_narrow_length_reference,
        rear_frame_crossbar_width_reference = rear_frame_crossbar_width_reference,
        rear_crossbar_1_reference = rear_crossbar_1_reference,
        rear_crossbar_2_reference = rear_crossbar_2_reference,
        rear_crossbar_3_reference = rear_crossbar_3_reference,
        rear_opening_corner_radius_reference = rear_opening_corner_radius_reference,
        rear_side_recess_margin_reference = rear_side_recess_margin_reference,
        rear_end_recess_margin_reference = rear_end_recess_margin_reference,
        rear_crossbar_recess_margin_reference = rear_crossbar_recess_margin_reference,
        rear_recess_corner_radius_reference = rear_recess_corner_radius_reference,
        data_connector_x_reference = reference_width / 2,
        data_connector_center_offset_reference = 113.5 * reference_height / height,
        data_connector_z_bottom_reference =
            reference_height/2 - (113.5 * reference_height / height),
        data_connector_z_top_reference =
            reference_height/2 + (113.5 * reference_height / height),
        data_connector_width_reference = 27.90 * reference_width / width,
        data_connector_height_reference = 9.50 * reference_height / height,
        data_connector_depth = data_connector_depth,
        data_connector_front_y = data_connector_front_y,
        power_connector_x_reference = power_connector_x_reference,
        power_connector_z_reference = power_connector_z_reference,
        power_connector_width = power_connector_width,
        power_connector_height = power_connector_height,
        power_connector_depth = power_connector_depth

    );

// Function: hub75_p5_64x32_panel_width()
// Description: Returns the physical panel width.
function hub75_p5_64x32_panel_width(panel) = panel.width;

// Function: hub75_p5_64x32_panel_height()
// Description: Returns the physical panel height.
function hub75_p5_64x32_panel_height(panel) = panel.height;

// Function: hub75_p5_64x32_panel_depth()
// Description: Returns the overall panel depth.
function hub75_p5_64x32_panel_depth(panel) = panel.depth;

function hub75_p5_64x32_panel_nominal_width(panel) = panel.reference_width;
function hub75_p5_64x32_panel_nominal_height(panel) = panel.reference_height;
function hub75_p5_64x32_panel_mounting_plane_y(panel) = panel.mounting_plane_y;
function hub75_rear_taper_start_y(panel) = panel.front_mask_depth + panel.pcb_thickness;
function hub75_rear_taper_depth(panel) =
    max(0.01, panel.mounting_plane_y - hub75_rear_taper_start_y(panel));

function hub75_p5_64x32_panel_hole_diameter(panel) = panel.hole_diameter;
function hub75_p5_64x32_panel_hole_x_positions(panel) = [panel.hole_x_left, panel.hole_x_right];
function hub75_p5_64x32_panel_hole_z_positions(panel) =
    [panel.hole_z_bottom, panel.hole_z_middle, panel.hole_z_top];

function hub75_p5_64x32_panel_hole_x_positions_centered(panel) =
    [for (x = hub75_p5_64x32_panel_hole_x_positions(panel)) x - panel.width/2];

function hub75_p5_64x32_panel_hole_z_positions_centered(panel) =
    [for (z = hub75_p5_64x32_panel_hole_z_positions(panel)) z - panel.height/2];

function hub75_p5_64x32_panel_grid_gap_x(panel) = panel.reference_width - panel.width;
function hub75_p5_64x32_panel_grid_gap_z(panel) = panel.reference_height - panel.height;
function hub75_p5_64x32_panel_grid_margin_x(panel) = hub75_p5_64x32_panel_grid_gap_x(panel)/2;
function hub75_p5_64x32_panel_grid_margin_z(panel) = hub75_p5_64x32_panel_grid_gap_z(panel)/2;

// Public mechanical mating data used by project-specific brackets/couplers.
// These accessors expose the same derived dimensions used by the production
// panel geometry so consumers do not need to reach into panel object internals.
function hub75_p5_64x32_panel_rear_outer_inset_x(panel) =
    panel.rear_outer_inset * panel.width / panel.reference_width;

function hub75_p5_64x32_panel_rear_outer_inset_z(panel) =
    panel.rear_outer_inset * panel.height / panel.reference_height;

function hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel) =
    max(
        0,
        panel.rear_frame_side_width_reference
        - hub75_p5_64x32_panel_rear_outer_inset_x(panel)
    );

function hub75_p5_64x32_panel_rear_end_rail_width_at_mounting_plane(panel) =
    max(
        0,
        panel.rear_frame_end_width_reference
        - hub75_p5_64x32_panel_rear_outer_inset_z(panel)
    );

function hub75_p5_64x32_panel_rear_end_narrow_width_at_mounting_plane(panel) =
    max(
        0,
        panel.rear_frame_end_narrow_width_reference
        - hub75_p5_64x32_panel_rear_outer_inset_z(panel)
    );

function hub75_p5_64x32_panel_rear_crossbar_width_at_mounting_plane(panel) =
    panel.rear_frame_crossbar_width_reference
    * panel.height
    / panel.reference_height;

function hub75_p5_64x32_panel_rear_opening_corner_radius(panel) =
    min(
        panel.rear_opening_corner_radius_reference
            * panel.width
            / panel.reference_width,
        panel.rear_opening_corner_radius_reference
            * panel.height
            / panel.reference_height
    );

function hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel) =
    panel.mounting_tube_outer_diameter;

function hub75_p5_64x32_panel_mounting_tube_protrusion(panel) =
    panel.mounting_tube_protrusion;

function hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel) =
    panel.reinforcement_bushing_outer_diameter;

function hub75_p5_64x32_panel_reinforcement_bushing_offset(panel) =
    panel.reinforcement_disc_offset;

function hub75_rear_outer_inset_x(panel) =
    hub75_p5_64x32_panel_rear_outer_inset_x(panel);
function hub75_rear_outer_inset_z(panel) =
    hub75_p5_64x32_panel_rear_outer_inset_z(panel);

function hub75_p5_64x32_panel_rear_grid_gap_x(panel) =
    panel.reference_width - (panel.width - 2*hub75_rear_outer_inset_x(panel));
function hub75_p5_64x32_panel_rear_grid_gap_z(panel) =
    panel.reference_height - (panel.height - 2*hub75_rear_outer_inset_z(panel));

function hub75_rear_side_rail_width_at_mounting_plane(panel) =
    hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel);
function hub75_rear_end_rail_width_at_mounting_plane(panel) =
    hub75_p5_64x32_panel_rear_end_rail_width_at_mounting_plane(panel);
function hub75_rear_end_narrow_width_at_mounting_plane(panel) =
    hub75_p5_64x32_panel_rear_end_narrow_width_at_mounting_plane(panel);

function hub75_p5_64x32_panel_data_connector_x(panel) = panel.width/2;
function hub75_p5_64x32_panel_data_connector_center_offset(panel) = 113.5;
function hub75_p5_64x32_panel_data_connector_z_bottom(panel) =
    panel.height/2 - hub75_p5_64x32_panel_data_connector_center_offset(panel);
function hub75_p5_64x32_panel_data_connector_z_top(panel) =
    panel.height/2 + hub75_p5_64x32_panel_data_connector_center_offset(panel);
function hub75_p5_64x32_panel_data_connector_width(panel) = 27.90;
function hub75_p5_64x32_panel_data_connector_height(panel) = 9.50;

function hub75_locator_pin_near_edge_screw_x_delta(panel) =
    panel.hole_x_left - (panel.width/2 - panel.locator_pin_landscape_y_offset);
function hub75_locator_pin_edge_screw_z_delta(panel) =
    panel.height/2 - panel.locator_pin_landscape_x_offset - panel.hole_z_bottom;

function _hub75_scale_x(value, width, reference_width) =
    value * width / reference_width;
function _hub75_scale_z(value, height, reference_height) =
    value * height / reference_height;

HUB75_P5_64X32_PANEL_BODY_LIGHT = [0.72, 0.72, 0.72, 1];
HUB75_P5_64X32_PANEL_WEB_LIGHT = [0.48, 0.48, 0.48, 1];
HUB75_P5_64X32_PANEL_FRONT_LIGHT = [0.52, 0.52, 0.52, 1];
HUB75_P5_64X32_PANEL_BODY_ORIGINAL = [0.08, 0.10, 0.09, 1];
HUB75_P5_64X32_PANEL_WEB_ORIGINAL = [0.045, 0.055, 0.050, 1];
HUB75_P5_64X32_PANEL_FRONT_ORIGINAL = [0.015, 0.015, 0.015, 1];
HUB75_P5_64X32_PANEL_PCB_COLOR = [0.02, 0.20, 0.07, 1];
HUB75_P5_64X32_PANEL_CONNECTOR_COLOR = [0.06, 0.06, 0.06, 1];

function _hub75_body_color(scheme) =
    scheme == "original" ? HUB75_P5_64X32_PANEL_BODY_ORIGINAL : HUB75_P5_64X32_PANEL_BODY_LIGHT;
function _hub75_web_color(scheme) =
    scheme == "original" ? HUB75_P5_64X32_PANEL_WEB_ORIGINAL : HUB75_P5_64X32_PANEL_WEB_LIGHT;
function _hub75_front_color(scheme) =
    scheme == "original" ? HUB75_P5_64X32_PANEL_FRONT_ORIGINAL : HUB75_P5_64X32_PANEL_FRONT_LIGHT;

// Module: hub75_p5_64x32_panel_build()
// Usage:
//   hub75_p5_64x32_panel_build(panel);
// Description:
//   Builds the complete reusable panel reference geometry.
// Arguments:
//   panel = HUB75 panel object created by hub75_p5_64x32_panel_create().
module hub75_p5_64x32_panel_build(panel) {
    _hub75_p5_64x32_panel_geometry(
        panel,
        show_orientation = true,
        show_connectors = true,
        show_front_layers = true,
        show_rear_recess = true,
        show_pdf_verification_grid = false,
        body_color = HUB75_P5_64X32_PANEL_BODY_ORIGINAL,
        web_color = HUB75_P5_64X32_PANEL_WEB_ORIGINAL,
        front_color = HUB75_P5_64X32_PANEL_FRONT_ORIGINAL,
        pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
        connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR
    );
}

// Module: hub75_p5_64x32_panel_render()
// Usage:
//   hub75_p5_64x32_panel_render(panel, HUB75_P5_64X32_PANEL_VIEW_REAR);
// Description:
//   Renders one stable documentation/debug view without changing panel data.
// Arguments:
//   panel = HUB75 panel object.
//   view = One HUB75_P5_64X32_PANEL_VIEW_* constant.
//   color_scheme = "light_gray" or "original".
module hub75_p5_64x32_panel_render(
    panel,
    view = HUB75_P5_64X32_PANEL_VIEW_FINAL,
    color_scheme = "light_gray"
) {
    body = _hub75_body_color(color_scheme);
    web = _hub75_web_color(color_scheme);
    front = _hub75_front_color(color_scheme);

    if (view >= HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE) {
        _hub75_p5_64x32_panel_geometry(
            panel,
            show_orientation = false,
            show_connectors = false,
            show_front_layers = true,
            show_rear_recess = true,
            show_pdf_verification_grid = false,
            body_color = [0.76, 0.76, 0.76, 0.34],
            web_color = [0.76, 0.76, 0.76, 0.34],
            front_color = [0.76, 0.76, 0.76, 0.34],
            pcb_color = [0.76, 0.76, 0.76, 0.34],
            connector_color = [0.76, 0.76, 0.76, 0.34],
            design_view = view
        );

    } else if (view == HUB75_P5_64X32_PANEL_VIEW_FRONT) {
        rotate([0, 180, 0])
            _hub75_p5_64x32_panel_geometry(
                panel,
                show_orientation = false,
                show_connectors = false,
                show_front_layers = true,
                show_rear_recess = false,
                show_pdf_verification_grid = false,
                body_color = body,
                web_color = web,
                front_color = front,
                pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
                connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR
            );

    } else if (view == HUB75_P5_64X32_PANEL_VIEW_REAR) {
        _hub75_p5_64x32_panel_geometry(
            panel,
            show_orientation = true,
            show_connectors = true,
            show_front_layers = false,
            show_rear_recess = true,
            show_pdf_verification_grid = false,
            body_color = body,
            web_color = web,
            front_color = front,
            pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
            connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR
        );

    } else if (view == HUB75_P5_64X32_PANEL_VIEW_STRUCTURE) {
        _hub75_p5_64x32_panel_geometry(
            panel,
            show_orientation = false,
            show_connectors = false,
            show_front_layers = false,
            show_rear_recess = true,
            show_pdf_verification_grid = false,
            body_color = body,
            web_color = web,
            front_color = front,
            pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
            connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR
        );

    } else if (view == HUB75_P5_64X32_PANEL_VIEW_CONNECTORS) {
        _hub75_p5_64x32_panel_geometry(
            panel,
            show_orientation = false,
            show_connectors = true,
            show_front_layers = false,
            show_rear_recess = false,
            show_pdf_verification_grid = false,
            body_color = [0.75, 0.75, 0.75, 0.35],
            web_color = [0.65, 0.65, 0.65, 0.35],
            front_color = front,
            pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
            connector_color = [1, 0, 0, 0.65]
        );

    } else if (view == HUB75_P5_64X32_PANEL_VIEW_VERIFICATION) {
        _hub75_p5_64x32_panel_geometry(
            panel,
            show_orientation = false,
            show_connectors = false,
            show_front_layers = false,
            show_rear_recess = true,
            show_pdf_verification_grid = true,
            body_color = [0.75, 0.75, 0.75, 0.45],
            web_color = [0.65, 0.65, 0.65, 0.45],
            front_color = front,
            pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
            connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR
        );

    } else {
        _hub75_p5_64x32_panel_geometry(
            panel,
            show_orientation = view != HUB75_P5_64X32_PANEL_VIEW_PROFILE,
            show_connectors = true,
            show_front_layers = true,
            show_rear_recess = true,
            show_pdf_verification_grid = false,
            body_color = body,
            web_color = web,
            front_color = front,
            pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
            connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR
        );
    }
}


// -----------------------------------------------------------------------------
// Internal geometry implementation
// -----------------------------------------------------------------------------

module _hub75_p5_64x32_panel_geometry(
    panel,
    show_orientation = true,
    show_connectors = true,
    show_front_layers = true,
    show_rear_recess = true,
    show_pdf_verification_grid = false,
    body_color = HUB75_P5_64X32_PANEL_BODY_ORIGINAL,
    web_color = HUB75_P5_64X32_PANEL_WEB_ORIGINAL,
    front_color = HUB75_P5_64X32_PANEL_FRONT_ORIGINAL,
    pcb_color = HUB75_P5_64X32_PANEL_PCB_COLOR,
    connector_color = HUB75_P5_64X32_PANEL_CONNECTOR_COLOR,
    design_view = 0
) {
    width = panel.width;
    height = panel.height;
    reference_width_value = panel.reference_width;
    reference_height_value = panel.reference_height;
    front_mask_depth_value = panel.front_mask_depth;
    pcb_thickness_value = panel.pcb_thickness;
    mounting_plane_y_value = panel.mounting_plane_y;
    max_depth_value = panel.max_depth;
    rear_recess_depth_value = panel.rear_recess_depth;
    rear_outer_inset_value = panel.rear_outer_inset;
    hole_x_left_value = panel.hole_x_left;
    hole_x_right_value = panel.hole_x_right;
    hole_z_bottom_value = panel.hole_z_bottom;
    hole_z_middle_value = panel.hole_z_middle;
    hole_z_top_value = panel.hole_z_top;
    hole_diameter_value = panel.hole_diameter;
    mounting_tube_outer_diameter_value = panel.mounting_tube_outer_diameter;
    mounting_tube_protrusion_value = panel.mounting_tube_protrusion;
    mounting_tube_relief_clearance_value = panel.mounting_tube_relief_clearance;
    mounting_tube_relief_depth_value = panel.mounting_tube_relief_depth;
    reinforcement_bushing_outer_diameter_value = panel.reinforcement_bushing_outer_diameter;
    reinforcement_bushing_inner_diameter_value = panel.reinforcement_bushing_inner_diameter;
    reinforcement_bushing_protrusion_value = panel.reinforcement_bushing_protrusion;
    reinforcement_bushing_inner_recess_value = panel.reinforcement_bushing_inner_recess;
    reinforcement_bushing_hole_diameter_value = panel.reinforcement_bushing_hole_diameter;
    reinforcement_bushing_hole_depth_value = panel.reinforcement_bushing_hole_depth;
    reinforcement_bushing_inner_depth = panel.reinforcement_bushing_inner_depth;
    reinforcement_disc_offset_value = panel.reinforcement_disc_offset;
    locator_pin_diameter_value = panel.locator_pin_diameter;
    locator_pin_protrusion_value = panel.locator_pin_protrusion;
    locator_pin_landscape_x_offset_value = panel.locator_pin_landscape_x_offset;
    locator_pin_landscape_y_offset_value = panel.locator_pin_landscape_y_offset;
    rear_frame_side_width_ref = panel.rear_frame_side_width_reference;
    rear_frame_end_width_ref = panel.rear_frame_end_width_reference;
    rear_frame_crossbar_width_ref = panel.rear_frame_crossbar_width_reference;
    rear_frame_end_narrow_width_ref = panel.rear_frame_end_narrow_width_reference;
    rear_frame_end_narrow_length_ref = panel.rear_frame_end_narrow_length_reference;
    rear_crossbar_1_ref = panel.rear_crossbar_1_reference;
    rear_crossbar_2_ref = panel.rear_crossbar_2_reference;
    rear_crossbar_3_ref = panel.rear_crossbar_3_reference;
    rear_opening_corner_radius_ref = panel.rear_opening_corner_radius_reference;
    rear_side_recess_margin_ref = panel.rear_side_recess_margin_reference;
    rear_end_recess_margin_ref = panel.rear_end_recess_margin_reference;
    rear_crossbar_recess_margin_ref = panel.rear_crossbar_recess_margin_reference;
    rear_recess_corner_radius_ref = panel.rear_recess_corner_radius_reference;
    data_connector_x_ref = panel.data_connector_x_reference;
    data_connector_z_bottom_ref = panel.data_connector_z_bottom_reference;
    data_connector_z_top_ref = panel.data_connector_z_top_reference;
    data_connector_width_ref = panel.data_connector_width_reference;
    data_connector_height_ref = panel.data_connector_height_reference;
    data_connector_depth_value = panel.data_connector_depth;
    data_connector_front_y_value = panel.data_connector_front_y;
    power_connector_x_ref = panel.power_connector_x_reference;
    power_connector_z_ref = panel.power_connector_z_reference;
    power_connector_width_value = panel.power_connector_width;
    power_connector_height_value = panel.power_connector_height;
    power_connector_depth_value = panel.power_connector_depth;


    // Mounting-hole positions are direct drawing dimensions.
    // They are intentionally NOT scaled from the STEP reference.
    hole_x_positions = [
        hole_x_left_value,
        hole_x_right_value
    ];

    hole_z_positions = [
        hole_z_bottom_value,
        hole_z_middle_value,
        hole_z_top_value
    ];

    // Separate reinforcement bushings beside the mounting tubes.
    // Portrait orientation is taken from the real rear-panel photo: landscape
    // X maps to decreasing portrait Z. This fixes the asymmetric middle pair:
    // the left middle bushing is above its mounting tube and the right middle
    // bushing is below it. The corner pairs remain inward along the long rail.
    reinforcement_bushing_positions = [
        [hole_x_left_value,  hole_z_bottom_value + reinforcement_disc_offset_value],
        [hole_x_right_value, hole_z_bottom_value + reinforcement_disc_offset_value],

        [hole_x_left_value,  hole_z_middle_value + reinforcement_disc_offset_value],
        [hole_x_right_value, hole_z_middle_value - reinforcement_disc_offset_value],

        [hole_x_left_value,  hole_z_top_value - reinforcement_disc_offset_value],
        [hole_x_right_value, hole_z_top_value - reinforcement_disc_offset_value]
    ];

    // PDF locating-pin centres. In this portrait rear-view orientation the
    // diagonal pair is upper-left and lower-right relative to panel centre.
    locator_pin_positions = [
        [width/2 - locator_pin_landscape_y_offset_value,
         height/2 + locator_pin_landscape_x_offset_value],
        [width/2 + locator_pin_landscape_y_offset_value,
         height/2 - locator_pin_landscape_x_offset_value]
    ];

    pcb_back_y =
        front_mask_depth_value
        + pcb_thickness_value;

    rear_frame_start_y = pcb_back_y;

    rear_frame_depth =
        mounting_plane_y_value
        - rear_frame_start_y;

    rear_recess_depth_actual =
        min(
            rear_recess_depth_value,
            rear_frame_depth
        );

    rear_outer_inset_actual =
        min(
            rear_outer_inset_value,
            min(width, height)/2 - 0.1
        );

    rear_frame_side_width =
        _hub75_scale_x(
            rear_frame_side_width_ref,
            width,
            reference_width_value
        );

    rear_frame_end_width =
        _hub75_scale_z(
            rear_frame_end_width_ref,
            height,
            reference_height_value
        );

    rear_frame_crossbar_width =
        _hub75_scale_z(
            rear_frame_crossbar_width_ref,
            height,
            reference_height_value
        );

    rear_frame_end_narrow_width =
        _hub75_scale_z(
            rear_frame_end_narrow_width_ref,
            height,
            reference_height_value
        );

    rear_frame_end_narrow_length =
        _hub75_scale_x(
            rear_frame_end_narrow_length_ref,
            width,
            reference_width_value
        );

    rear_frame_end_step_depth =
        max(0, rear_frame_end_width - rear_frame_end_narrow_width);

    rear_opening_corner_radius =
        min(
            _hub75_scale_x(
                rear_opening_corner_radius_ref,
                width,
                reference_width_value
            ),
            _hub75_scale_z(
                rear_opening_corner_radius_ref,
                height,
                reference_height_value
            )
        );

    rear_side_recess_margin =
        _hub75_scale_x(
            rear_side_recess_margin_ref,
            width,
            reference_width_value
        );

    rear_end_recess_margin =
        _hub75_scale_z(
            rear_end_recess_margin_ref,
            height,
            reference_height_value
        );

    rear_crossbar_recess_margin =
        _hub75_scale_z(
            rear_crossbar_recess_margin_ref,
            height,
            reference_height_value
        );

    rear_recess_corner_radius =
        min(
            _hub75_scale_x(
                rear_recess_corner_radius_ref,
                width,
                reference_width_value
            ),
            _hub75_scale_z(
                rear_recess_corner_radius_ref,
                height,
                reference_height_value
            )
        );

    rear_crossbar_z = [
        _hub75_scale_z(
            rear_crossbar_1_ref,
            height,
            reference_height_value
        ),
        _hub75_scale_z(
            rear_crossbar_2_ref,
            height,
            reference_height_value
        ),
        _hub75_scale_z(
            rear_crossbar_3_ref,
            height,
            reference_height_value
        )
    ];

    // Four rear bay limits in portrait orientation.
    opening_z_min = [
        rear_frame_end_width,
        rear_crossbar_z[0] + rear_frame_crossbar_width/2,
        rear_crossbar_z[1] + rear_frame_crossbar_width/2,
        rear_crossbar_z[2] + rear_frame_crossbar_width/2
    ];

    opening_z_max = [
        rear_crossbar_z[0] - rear_frame_crossbar_width/2,
        rear_crossbar_z[1] - rear_frame_crossbar_width/2,
        rear_crossbar_z[2] - rear_frame_crossbar_width/2,
        height - rear_frame_end_width
    ];

    data_connector_x =
        _hub75_scale_x(
            data_connector_x_ref,
            width,
            reference_width_value
        );

    data_connector_z_bottom =
        _hub75_scale_z(
            data_connector_z_bottom_ref,
            height,
            reference_height_value
        );

    data_connector_z_top =
        _hub75_scale_z(
            data_connector_z_top_ref,
            height,
            reference_height_value
        );

    data_connector_width =
        _hub75_scale_x(
            data_connector_width_ref,
            width,
            reference_width_value
        );

    data_connector_height =
        _hub75_scale_z(
            data_connector_height_ref,
            height,
            reference_height_value
        );

    // Approximate position from the supplied rear photograph: third bay in
    // landscape orientation. It is intentionally kept as a reference value
    // because the dimensional drawing does not locate this connector.
    power_connector_x =
        _hub75_scale_x(
            power_connector_x_ref,
            width,
            reference_width_value
        );

    power_connector_z =
        _hub75_scale_z(
            power_connector_z_ref,
            height,
            reference_height_value
        );


    // -------------------------------------------------------------------------
    // 2D helpers for the X/Z rear-frame profile
    // -------------------------------------------------------------------------

    module _rounded_rect_2d(x, z, w, h, r) {
        rr = min(r, min(w, h)/2 - 0.01);

        translate([x + rr, z + rr])
            offset(r=rr)
                square([
                    max(0.02, w - 2*rr),
                    max(0.02, h - 2*rr)
                ]);
    }


    // Central relief in the top and bottom edge of each electronics bay.
    // The STEP does not use a constant straight rail here: the normal rail
    // width is 10.75 mm and locally narrows to 7.75 mm. The 3 mm difference
    // is decomposed into a narrow centre strip plus two 45-degree transition
    // triangles. The production model and the design views share these helpers.
    module _bay_end_narrow_relief_2d(z_edge, direction=1) {
        d = rear_frame_end_step_depth;
        half_narrow = rear_frame_end_narrow_length/2;
        cx = width/2;

        if(d > 0)
            polygon([
                [cx-half_narrow, z_edge],
                [cx-half_narrow, z_edge + direction*d],
                [cx+half_narrow, z_edge + direction*d],
                [cx+half_narrow, z_edge]
            ]);
    }


    module _bay_end_transition_relief_2d(
        z_edge,
        direction=1,
        side="left"
    ) {
        d = rear_frame_end_step_depth;
        half_narrow = rear_frame_end_narrow_length/2;
        cx = width/2;

        if(d > 0)
            if(side == "left")
                polygon([
                    [cx-half_narrow-d, z_edge],
                    [cx-half_narrow,   z_edge + direction*d],
                    [cx-half_narrow,   z_edge]
                ]);
            else
                polygon([
                    [cx+half_narrow,   z_edge],
                    [cx+half_narrow,   z_edge + direction*d],
                    [cx+half_narrow+d, z_edge]
                ]);
    }


    module _bay_end_relief_2d(z_edge, direction=1) {
        union() {
            _bay_end_transition_relief_2d(z_edge, direction, "left");
            _bay_end_narrow_relief_2d(z_edge, direction);
            _bay_end_transition_relief_2d(z_edge, direction, "right");
        }
    }


    module _rear_opening_2d(i, include_reliefs=true) {
        z0 = opening_z_min[i];
        z1 = opening_z_max[i];
        opening_h = z1 - z0;

        union() {
            _rounded_rect_2d(
                rear_frame_side_width,
                z0,
                width - 2*rear_frame_side_width,
                opening_h,
                rear_opening_corner_radius
            );

            if(include_reliefs) {
                // Extend the opening locally into both adjacent rails.
                _bay_end_relief_2d(z0, -1);
                _bay_end_relief_2d(z1,  1);
            }
        }
    }


    module _rear_openings_2d() {
        for(i=[0:3])
            _rear_opening_2d(i);
    }


    module _rear_frame_web_2d(outer_inset=0) {
        difference() {
            translate([outer_inset, outer_inset])
                square([
                    width - 2*outer_inset,
                    height - 2*outer_inset
                ]);

            _rear_openings_2d();
        }
    }

    module _rear_frame_body_2d() {
        _rear_frame_web_2d();
    }


    module _reinforcement_bushing_footprints_2d() {
        // Footprints of the six separate Ø14 mm reinforcement bushings.
        // These are used only to prevent the shallow rail recess from cutting
        // through the bushing base. The 3D stepped bushing is added later.
        for(pos=reinforcement_bushing_positions)
            translate([pos[0], pos[1]])
                circle(d=reinforcement_bushing_outer_diameter_value, $fn=64);
    }


    module _rear_side_recess_2d(side="left") {
        side_margin = rear_side_recess_margin;
        r = rear_recess_corner_radius;
        outer_inset = rear_outer_inset_actual;

        side_recess_w =
            rear_frame_side_width
            - outer_inset
            - 2*side_margin;

        side_recess_h =
            height
            - 2*rear_frame_end_width;

        if(side_recess_w > 0 && side_recess_h > 0)
            _rounded_rect_2d(
                side == "left"
                    ? outer_inset + side_margin
                    : width - rear_frame_side_width + side_margin,
                rear_frame_end_width,
                side_recess_w,
                side_recess_h,
                r
            );
    }


    module _rear_end_recess_2d(end="bottom") {
        end_margin = rear_end_recess_margin;
        outer_inset = rear_outer_inset_actual;
        end_band_h = rear_frame_end_width - outer_inset;
        end_band_w = width - 2*rear_frame_side_width;

        // Follow the ACTUAL stepped end-rail contour instead of recessing a
        // plain rectangle.  The bay-end narrowing changes the inner edge of
        // the top/bottom rail; offsetting that real profile keeps a continuous
        // rim on both the outside edge and the stepped inside edge.
        if(end_band_w > 0 && end_band_h > 0 && end_margin > 0)
            offset(delta=-end_margin)
                intersection() {
                    _rear_frame_web_2d(outer_inset);

                    translate([
                        rear_frame_side_width,
                        end == "bottom"
                            ? outer_inset
                            : height - rear_frame_end_width
                    ])
                        square([
                            end_band_w,
                            end_band_h
                        ]);
                }
    }


    module _rear_crossbar_recess_2d(i) {
        cross_margin = rear_crossbar_recess_margin;
        end_recess_w = width - 2*rear_frame_side_width;
        zc = rear_crossbar_z[i];

        if(end_recess_w > 0 && cross_margin > 0)
            offset(delta=-cross_margin)
                intersection() {
                    // Important: use the ACTUAL stepped frame profile.
                    _rear_frame_web_2d();

                    translate([
                        rear_frame_side_width,
                        zc - rear_frame_crossbar_width/2
                    ])
                        square([
                            width - 2*rear_frame_side_width,
                            rear_frame_crossbar_width
                        ]);
                }
    }


    module _rear_recess_raw_2d() {
        union() {
            _rear_side_recess_2d("left");
            _rear_side_recess_2d("right");

            _rear_end_recess_2d("bottom");
            _rear_end_recess_2d("top");

            for(i=[0:2])
                _rear_crossbar_recess_2d(i);
        }
    }


    module _rear_recess_2d() {
        // Build all recessed strips first, then protect the six reinforcement
        // footprints from that shallow cut.
        difference() {
            _rear_recess_raw_2d();
            _reinforcement_bushing_footprints_2d();
        }
    }


    module _rear_extrude_from_to(y0, y1) {
        depth = max(0, y1 - y0);

        if(depth > 0)
            translate([0, y1, 0])
                rotate([90, 0, 0])
                    linear_extrude(
                        height=depth,
                        convexity=8
                    )
                        children();
    }


    // Tapered outer envelope in X/Z, extruded along Y.
    // STEP relation: 1.25 mm inset per side between the full-size front of
    // the rear housing and its rear perimeter face (2.50 mm smaller overall).
    // Only the external perimeter changes. The four rear bay openings are
    // subtracted separately, so their edges and the three separator rails do
    // not get scaled or shifted by the taper.
    module _tapered_outer_blank(y0, y1, inset0, inset1) {
        x0a = inset0;
        x1a = width - inset0;
        z0a = inset0;
        z1a = height - inset0;

        x0b = inset1;
        x1b = width - inset1;
        z0b = inset1;
        z1b = height - inset1;

        polyhedron(
            points=[
                [x0a, y0, z0a],
                [x1a, y0, z0a],
                [x1a, y0, z1a],
                [x0a, y0, z1a],
                [x0b, y1, z0b],
                [x1b, y1, z0b],
                [x1b, y1, z1b],
                [x0b, y1, z1b]
            ],
            faces=[
                [0,3,2,1],
                [4,5,6,7],
                [0,1,5,4],
                [1,2,6,5],
                [2,3,7,6],
                [3,0,4,7]
            ],
            convexity=8
        );
    }


    module _rear_frame_core_3d() {
        difference() {
            // The full outside wall tapers continuously from the 2.0 mm
            // rear-housing start to the rear mounting plane. There is no
            // artificial short chamfer followed by a straight wall.
            _tapered_outer_blank(
                rear_frame_start_y,
                mounting_plane_y_value,
                0,
                rear_outer_inset_actual
            );

            // Keep the bay walls vertical, as in the STEP model.
            _rear_extrude_from_to(
                rear_frame_start_y - 0.05,
                mounting_plane_y_value + 0.05
            )
                _rear_openings_2d();
        }
    }


    module _reinforcement_bushing_solids() {
        // The reinforcement is circular on the bay/interior side, but it is
        // NOT allowed to bulge through the panel's outside wall.  Build the
        // Ø14 cylinders first, then clip them with the same tapered external
        // envelope that defines the rear housing.  This keeps the inner
        // reinforcement shape while making the outer wall continuous/flush.
        intersection() {
            union()
                for(pos=reinforcement_bushing_positions)
                    translate([
                        pos[0],
                        mounting_plane_y_value - reinforcement_bushing_inner_depth,
                        pos[1]
                    ])
                        rotate([-90, 0, 0])
                            cylinder(
                                h=reinforcement_bushing_inner_depth,
                                d=reinforcement_bushing_outer_diameter_value,
                                $fn=64
                            );

            _tapered_outer_blank(
                rear_frame_start_y,
                mounting_plane_y_value,
                0,
                rear_outer_inset_actual
            );
        }
    }


    module _reinforcement_bushing_inner_recess_cuts() {
        // Ø10 recess, 2.5 mm deep from the rear mounting plane.
        for(pos=reinforcement_bushing_positions)
            translate([
                pos[0],
                mounting_plane_y_value - reinforcement_bushing_inner_recess_value,
                pos[1]
            ])
                rotate([-90, 0, 0])
                    cylinder(
                        h=reinforcement_bushing_inner_recess_value + 0.02,
                        d=reinforcement_bushing_inner_diameter_value,
                        $fn=64
                    );
    }


    module _reinforcement_bushing_blind_hole_cuts() {
        // Ø2.5 blind hole, 10 mm deeper from the recess floor.
        for(pos=reinforcement_bushing_positions)
            translate([
                pos[0],
                mounting_plane_y_value
                    - reinforcement_bushing_inner_recess_value
                    - reinforcement_bushing_hole_depth_value,
                pos[1]
            ])
                rotate([-90, 0, 0])
                    cylinder(
                        h=reinforcement_bushing_hole_depth_value + 0.02,
                        d=reinforcement_bushing_hole_diameter_value,
                        $fn=48
                    );
    }


    module _reinforcement_bushing_cuts() {
        // The Ø14 reinforcement feature is NOT an added boss. The rear rail
        // itself remains flush at the nominal mounting plane because its Ø14
        // footprint is excluded from _rear_recess_2d(). Only the inner recess
        // and blind hole are cut from that retained rail material here.
        _reinforcement_bushing_inner_recess_cuts();
        _reinforcement_bushing_blind_hole_cuts();
    }


    module _locator_pin(x, z) {
        // Solid Ø3 mm locating pin standing 3 mm proud of the nominal rear
        // mounting plane. Diameter and X/Z location come from the PDF; the
        // 3 mm protrusion is the measured physical value.
        translate([x, mounting_plane_y_value, z])
            rotate([-90, 0, 0])
                cylinder(
                    h=locator_pin_protrusion_value,
                    d=locator_pin_diameter_value,
                    $fn=48
                );
    }


    module _mounting_tube(x, z) {
        // A mounting point is a simple cylindrical tube around the Ø3 mm
        // screw hole. Do not merge the separate STEP reinforcement discs into
        // this feature.
        difference() {
            translate([
                x,
                rear_frame_start_y,
                z
            ])
                rotate([-90, 0, 0])
                    cylinder(
                        h=
                            mounting_plane_y_value
                            - rear_frame_start_y
                            + mounting_tube_protrusion_value,
                        d=mounting_tube_outer_diameter_value,
                        $fn=64
                    );

            translate([
                x,
                -0.2,
                z
            ])
                rotate([-90, 0, 0])
                    cylinder(
                        h=mounting_plane_y_value + mounting_tube_protrusion_value + 0.5,
                        d=hole_diameter_value,
                        $fn=40
                    );
        }
    }


    // Rear-frame construction states. These are normal production helpers:
    // the final geometry is composed from them and the design renderer can
    // stop at the state immediately before the operation being explained.
    module _rear_frame_base() {
        union() {
            _rear_frame_core_3d();
            _reinforcement_bushing_solids();
        }
    }


    module _rear_frame_after_recess() {
        difference() {
            _rear_frame_base();

            if(show_rear_recess && rear_recess_depth_actual > 0)
                _rear_extrude_from_to(
                    mounting_plane_y_value - rear_recess_depth_actual,
                    mounting_plane_y_value + 0.05
                )
                    _rear_recess_2d();
        }
    }


    module _mounting_tube_relief_cutters() {
        if(mounting_tube_relief_depth_value > 0
           && mounting_tube_relief_clearance_value > 0)
            _rear_extrude_from_to(
                mounting_plane_y_value - mounting_tube_relief_depth_value,
                mounting_plane_y_value + 0.05
            )
                for(x=hole_x_positions)
                    for(z=hole_z_positions)
                        translate([x, z])
                            circle(
                                d=mounting_tube_outer_diameter_value
                                    + 2*mounting_tube_relief_clearance_value,
                                $fn=64
                            );
    }


    module _rear_frame_after_mounting_reliefs() {
        difference() {
            _rear_frame_after_recess();
            _mounting_tube_relief_cutters();
        }
    }


    module _rear_frame_with_mounting_tubes() {
        union() {
            _rear_frame_after_mounting_reliefs();

            for(x=hole_x_positions)
                for(z=hole_z_positions)
                    _mounting_tube(x, z);
        }
    }


    module _rear_frame_after_reinforcement_cuts() {
        difference() {
            _rear_frame_with_mounting_tubes();
            _reinforcement_bushing_cuts();
        }
    }


    module _rear_frame_structure() {
        color(body_color)
            _rear_frame_after_reinforcement_cuts();

        color(body_color)
            for(pos=locator_pin_positions)
                _locator_pin(pos[0], pos[1]);
    }


    module _hub75_data_connector(z) {
        color(connector_color)
            translate([
                data_connector_x
                    - data_connector_width/2,
                data_connector_front_y_value,
                z
                    - data_connector_height/2
            ])
                cube([
                    data_connector_width,
                    data_connector_depth_value,
                    data_connector_height
                ]);

        // Visual opening on the rear-facing side.
        color([0.015, 0.015, 0.015, 1])
            translate([
                data_connector_x
                    - data_connector_width*0.39,
                data_connector_front_y_value
                    + data_connector_depth_value
                    - 0.4,
                z
                    - data_connector_height*0.31
            ])
                cube([
                    data_connector_width*0.78,
                    0.8,
                    data_connector_height*0.62
                ]);
    }


    module _pcb_arrow(x, z, direction = "down", arrow_scale = 0.55, arrow_color = [0.85, 0.85, 0.85, 1]) {
        // Simple rear-PCB orientation marker. These arrows are included because
        // they make the portrait rotation of the real panel unambiguous.
        // They are visual reference features, not dimensional geometry.
        rot_y =
            direction == "down"  ? 0 :
            direction == "up"    ? 180 :
            direction == "left"  ? -90 :
            direction == "right" ? 90 : 0;

        color(arrow_color)
            translate([
                x,
                mounting_plane_y_value + 0.01,
                z
            ])
                rotate([90, rot_y, 0])
                    linear_extrude(height=0.35)
                        scale([arrow_scale, arrow_scale])
                            polygon([
                                [-4, 18],
                                [ 4, 18],
                                [ 4, -5],
                                [10, -5],
                                [ 0, -18],
                                [-10, -5],
                                [-4, -5]
                            ]);
    }


    module _orientation_arrows() {
        // Rear-view portrait orientation, bays counted from top to bottom:
        // bay 1: downward arrow beside the connector
        // bay 2: right-pointing arrow at the right side
        // bay 3: no arrow
        // bay 4: downward arrow toward the power connector + right-pointing arrow

        // Bay 1 (top): down arrow beside the HUB75 connector.
        _pcb_arrow(
            min(width - 28, data_connector_x + 38),
            data_connector_z_top,
            "down",
            0.42
        );

        // Bay 2: right arrow close to the VISUAL right side in rear view.
        // Rear viewing reverses the X direction on screen, so this uses the low-X side.
        _pcb_arrow(
            20,
            (opening_z_min[2] + opening_z_max[2]) / 2,
            "right",
            0.50
        );

        // Bay 3 intentionally has no orientation arrow. The POWER connector
        // itself is in this bay.

        // Bay 4 (bottom): down arrow aligned in X with the bay-1 down arrow.
        _pcb_arrow(
            min(width - 28, data_connector_x + 38),
            (opening_z_min[0] + opening_z_max[0]) / 2,
            "down",
            0.42
        );

        // Bay 4: right arrow close to the VISUAL right side, like the bay-2 marker.
        _pcb_arrow(
            20,
            (opening_z_min[0] + opening_z_max[0]) / 2,
            "right",
            0.50
        );
    }


    module _power_connector_model() {
        color([0.05, 0.05, 0.05, 1])
            translate([
                power_connector_x
                    - power_connector_width_value/2,
                pcb_back_y + 1.0,
                power_connector_z
                    - power_connector_height_value/2
            ])
                cube([
                    power_connector_width_value,
                    power_connector_depth_value,
                    power_connector_height_value
                ]);

        for(pz=[-7.5, -2.5, 2.5, 7.5])
            color([0.45, 0.45, 0.42, 1])
                translate([
                    power_connector_x - 2.75,
                    pcb_back_y
                        + power_connector_depth_value
                        + 1.1,
                    power_connector_z
                        + pz
                        - 1.2
                ])
                    cube([
                        5.5,
                        0.7,
                        2.4
                    ]);
    }


    // -------------------------------------------------------------------------
    // PDF verification overlay
    // -------------------------------------------------------------------------

    module _pdf_verification_grid() {
        // Red construction raster derived only from dimensions that are explicit
        // in the supplied PDF / mounting-hole layout:
        //   overall envelope : 159.70 x 319.71 mm in this portrait orientation
        //   mounting columns : 72 mm either side of panel centre
        //   mounting rows    : 152 mm either side of centre, plus centre row
        //
        // The overlay deliberately does not encode STEP-only rear-frame details.
        // It sits just behind the rearmost physical features so it remains
        // visible as a pure visual verification aid.
        grid_y = max(
            max(
                mounting_plane_y_value + mounting_tube_protrusion_value,
                mounting_plane_y_value + reinforcement_bushing_protrusion_value
            ),
            mounting_plane_y_value + locator_pin_protrusion_value
        ) + 0.35;
        line_w = 0.35;
        line_d = 0.12;
        target_d = 2.0;
        target_ring = 0.30;

        module _hline(z, w=width) {
            translate([0, grid_y, z-line_w/2])
                color([1,0,0,0.85])
                    cube([w, line_d, line_w]);
        }

        module _vline(x, h=height) {
            translate([x-line_w/2, grid_y, 0])
                color([1,0,0,0.85])
                    cube([line_w, line_d, h]);
        }

        module _target(x,z) {
            color([1,0,0,0.95])
                translate([x, grid_y + line_d/2, z])
                    rotate([-90,0,0])
                        difference() {
                            cylinder(h=line_d, d=target_d, $fn=48);
                            translate([0,0,-0.01])
                                cylinder(h=line_d+0.02, d=max(0.1,target_d-2*target_ring), $fn=48);
                        }
        }

        // Overall PDF envelope.
        _hline(0);
        _hline(height);
        _vline(0);
        _vline(width);

        // Panel centre axes.
        _hline(height/2);
        _vline(width/2);

        // PDF mounting-hole centre lines. These resolve, after centring, to
        // approximately X = +/-72 mm and Z = -152 / 0 / +152 mm.
        for(x=hole_x_positions)
            _vline(x);

        for(z=hole_z_positions)
            _hline(z);

        // Explicit targets at the six PDF mounting centres.
        for(x=hole_x_positions)
            for(z=hole_z_positions)
                _target(x,z);

        // The two Ø3 locating-pin centres are also explicitly dimensioned in
        // the PDF: ±110 mm horizontally and ±75 mm vertically in landscape.
        for(pos=locator_pin_positions)
            _target(pos[0], pos[1]);
    }


    // -------------------------------------------------------------------------
    // Reusable construction geometry
    // -------------------------------------------------------------------------

    module _front_mask_shape() {
        cube([
            width,
            front_mask_depth_value,
            height
        ]);
    }


    module _pcb_layer_shape() {
        translate([
            0,
            front_mask_depth_value,
            0
        ])
            cube([
                width,
                pcb_thickness_value,
                height
            ]);
    }


    module _panel_solid_before_mounting_holes() {
        union() {
            if(show_front_layers) {
                color(front_color)
                    _front_mask_shape();

                color(pcb_color)
                    _pcb_layer_shape();
            }

            _rear_frame_structure();

            if(show_connectors) {
                _hub75_data_connector(data_connector_z_bottom);
                _hub75_data_connector(data_connector_z_top);
                _power_connector_model();
            }

            if(show_orientation)
                _orientation_arrows();
        }
    }


    module _mounting_hole_cutters() {
        for(x=hole_x_positions)
            for(z=hole_z_positions)
                translate([
                    x,
                    -0.5,
                    z
                ])
                    rotate([-90, 0, 0])
                        cylinder(
                            h=max_depth_value + 1.0,
                            d=hole_diameter_value,
                            $fn=30
                        );
    }


    module _panel_final_local() {
        union() {
            difference() {
                _panel_solid_before_mounting_holes();
                _mounting_hole_cutters();
            }

            if(show_pdf_verification_grid)
                _pdf_verification_grid();
        }
    }


    // -------------------------------------------------------------------------
    // Design-documentation helpers
    // -------------------------------------------------------------------------

    DESIGN_EXISTING = [0.76, 0.76, 0.76, 0.34];
    DESIGN_EXISTING_SOLID = [0.76, 0.76, 0.76, 1.00];
    DESIGN_NEW = [1.00, 0.05, 0.05, 0.52];
    DESIGN_NEW_SOLID = [1.00, 0.05, 0.05, 0.92];
    DESIGN_CUT = [1.00, 0.05, 0.05, 0.34];
    DESIGN_GUIDE = [1.00, 0.05, 0.05, 0.80];

    module _design_front_context() {
        color(DESIGN_EXISTING) {
            _front_mask_shape();
            _pcb_layer_shape();
        }
    }

    module _design_frame_context(include_front=true) {
        if(include_front)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_core_3d();
    }

    module _design_rear_context_base() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_base();
    }


    module _design_rear_context_after_recess() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_after_recess();
    }


    module _design_rear_context_after_mounting_reliefs() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_after_mounting_reliefs();
    }


    module _design_rear_context_with_mounting_tubes() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_with_mounting_tubes();
    }


    module _design_rear_context_after_reinforcement_inner_recess() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            difference() {
                _rear_frame_with_mounting_tubes();
                _reinforcement_bushing_inner_recess_cuts();
            }
    }


    module _design_rear_context_after_reinforcement_cuts() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_after_reinforcement_cuts();
    }


    module _design_rear_structure_context() {
        if(show_front_layers)
            _design_front_context();

        color(DESIGN_EXISTING)
            _rear_frame_structure();
    }

    module _design_full_context() {
        color(DESIGN_EXISTING) {
            _front_mask_shape();
            _pcb_layer_shape();
        }

        _rear_frame_structure();

        _hub75_data_connector(data_connector_z_bottom);
        _hub75_data_connector(data_connector_z_top);
        _power_connector_model();
    }

    module _design_thin_2d(y=mounting_plane_y_value+0.8, depth=0.22) {
        translate([0, y + depth, 0])
            rotate([90,0,0])
                linear_extrude(height=depth)
                    children();
    }

    module _design_plane_y(y, plane_color=DESIGN_GUIDE) {
        color(plane_color)
            translate([0, y, 0])
                cube([width, 0.18, height]);
    }


    // Thin X slice used only for design/profile explanation.
    module _design_x_section(x, thickness=0.45) {
        intersection() {
            children();

            translate([
                x-thickness/2,
                -1,
                0
            ])
                cube([
                    thickness,
                    max_depth_value + 8,
                    height
                ]);
        }
    }

    module _design_nominal_outline() {
        t = 0.55;
        y = mounting_plane_y_value + 1.3;
        nominal_x0 = (width-reference_width_value)/2;
        nominal_z0 = (height-reference_height_value)/2;

        color(DESIGN_NEW_SOLID)
            translate([nominal_x0, y, nominal_z0]) {
                cube([reference_width_value, 0.20, t]);
                translate([0,0,reference_height_value-t])
                    cube([reference_width_value,0.20,t]);
                cube([t,0.20,reference_height_value]);
                translate([reference_width_value-t,0,0])
                    cube([t,0.20,reference_height_value]);
            }
    }

    module _design_x_grid_gap() {
        gap = reference_width_value - width;
        if(gap > 0)
            color(DESIGN_NEW)
                translate([-gap/2, mounting_plane_y_value+1.0, 0])
                    cube([gap,0.25,height]);
    }

    module _design_z_grid_gap() {
        gap = reference_height_value - height;
        if(gap > 0)
            color(DESIGN_NEW)
                translate([0,mounting_plane_y_value+1.0,-gap/2])
                    cube([width,0.25,gap]);
    }

    module _design_rear_footprint(inset=0, y=mounting_plane_y_value+0.8) {
        color(DESIGN_NEW)
            _design_thin_2d(y)
                translate([inset,inset])
                    square([
                        width-2*inset,
                        height-2*inset
                    ]);
    }

    module _design_bay(i, include_reliefs=true) {
        color(DESIGN_CUT)
            _rear_extrude_from_to(
                rear_frame_start_y-0.05,
                mounting_plane_y_value+0.3
            )
                _rear_opening_2d(i, include_reliefs);
    }

    module _design_recess_part_3d() {
        color(DESIGN_CUT)
            _rear_extrude_from_to(
                mounting_plane_y_value-rear_recess_depth_actual,
                mounting_plane_y_value+0.25
            )
                children();
    }

    module _design_mounting_positions(selector="all") {
        color(DESIGN_NEW_SOLID)
            for(xi=[0:1])
                for(zi=[0:2])
                    if(
                        selector == "all"
                        || (selector == "left" && xi == 0)
                        || (selector == "right" && xi == 1)
                        || (selector == "bottom" && zi == 0)
                        || (selector == "middle" && zi == 1)
                        || (selector == "top" && zi == 2)
                    )
                        translate([
                            hole_x_positions[xi],
                            mounting_plane_y_value+1.0,
                            hole_z_positions[zi]
                        ])
                            rotate([-90,0,0])
                                cylinder(h=0.35,d=8.0,$fn=40);
    }

    module _design_mounting_relief(x, z) {
        color(DESIGN_CUT)
            _rear_extrude_from_to(
                mounting_plane_y_value-mounting_tube_relief_depth_value,
                mounting_plane_y_value+0.25
            )
                translate([x,z])
                    circle(
                        d=mounting_tube_outer_diameter_value
                            + 2*mounting_tube_relief_clearance_value,
                        $fn=64
                    );
    }

    module _design_mounting_hole(x,z) {
        color(DESIGN_CUT)
            translate([x,-0.5,z])
                rotate([-90,0,0])
                    cylinder(
                        h=max_depth_value+1.0,
                        d=hole_diameter_value,
                        $fn=30
                    );
    }

    module _design_reinforcement_position(i) {
        pos = reinforcement_bushing_positions[i];
        color(DESIGN_NEW_SOLID)
            translate([
                pos[0],
                mounting_plane_y_value+0.8,
                pos[1]
            ])
                rotate([-90,0,0])
                    cylinder(h=0.28,d=reinforcement_bushing_outer_diameter_value,$fn=64);
    }

    module _design_reinforcement_inner_recess() {
        color(DESIGN_CUT)
            _reinforcement_bushing_inner_recess_cuts();
    }

    module _design_reinforcement_blind_hole() {
        color(DESIGN_CUT)
            _reinforcement_bushing_blind_hole_cuts();
    }

    module _design_connector_box(z) {
        color(DESIGN_NEW)
            translate([
                data_connector_x-data_connector_width/2,
                data_connector_front_y_value,
                z-data_connector_height/2
            ])
                cube([
                    data_connector_width,
                    data_connector_depth_value,
                    data_connector_height
                ]);
    }

    module _design_power_box() {
        color(DESIGN_NEW)
            translate([
                power_connector_x-power_connector_width_value/2,
                pcb_back_y+1.0,
                power_connector_z-power_connector_height_value/2
            ])
                cube([
                    power_connector_width_value,
                    power_connector_depth_value,
                    power_connector_height_value
                ]);
    }

    module _design_arrow_marker(x,z,direction,scale=0.5) {
        // Reuse the production arrow geometry through its actual private helper.
        _pcb_arrow(x,z,direction,scale,DESIGN_NEW_SOLID);
    }

    module _design_scene(view) {
        // Fine-grained design views start after the normal final view.
        if(view == HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE) {
            color(DESIGN_EXISTING) _front_mask_shape();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_NOMINAL_ENVELOPE) {
            color(DESIGN_EXISTING) _front_mask_shape();
            _design_nominal_outline();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_GRID_GAP_X) {
            color(DESIGN_EXISTING) _front_mask_shape();
            _design_nominal_outline();
            _design_x_grid_gap();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_GRID_GAP_Z) {
            color(DESIGN_EXISTING) _front_mask_shape();
            _design_nominal_outline();
            _design_z_grid_gap();

        // Front stack
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_FRONT_MASK) {
            color(DESIGN_NEW) _front_mask_shape();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_FRONT_MASK_DEPTH) {
            color(DESIGN_EXISTING) _front_mask_shape();
            _design_plane_y(front_mask_depth_value, DESIGN_NEW);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_PCB_LAYER) {
            color(DESIGN_EXISTING) _front_mask_shape();
            color(DESIGN_NEW) _pcb_layer_shape();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_PCB_BACK_PLANE) {
            _design_front_context();
            _design_plane_y(pcb_back_y, DESIGN_NEW);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_FRONT_STACK) {
            color(DESIGN_EXISTING_SOLID) _front_mask_shape();
            color(DESIGN_NEW) _pcb_layer_shape();

        // Rear envelope and taper
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_START_PLANE) {
            _design_front_context();
            _design_plane_y(rear_frame_start_y, DESIGN_NEW);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_DEPTH) {
            _design_front_context();
            _design_plane_y(rear_frame_start_y, DESIGN_EXISTING);
            _design_plane_y(mounting_plane_y_value, DESIGN_NEW);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_TAPER_FRONT_FOOTPRINT) {
            _design_front_context();
            _design_rear_footprint(0,rear_frame_start_y+0.4);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_TAPER_REAR_FOOTPRINT) {
            _design_front_context();
            _design_rear_footprint(rear_outer_inset_actual,mounting_plane_y_value+0.4);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_TAPER_BODY) {
            _design_front_context();
            color(DESIGN_NEW)
                _tapered_outer_blank(
                    rear_frame_start_y,
                    mounting_plane_y_value,
                    0,
                    rear_outer_inset_actual
                );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_TAPER_INSET_X) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d(mounting_plane_y_value+0.5)
                    translate([0,0])
                        square([rear_outer_inset_actual,height]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_TAPER_INSET_Z) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d(mounting_plane_y_value+0.5)
                    translate([0,0])
                        square([width,rear_outer_inset_actual]);

        // Frame dimensions
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_SIDE_RAIL_WIDTH) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    square([rear_frame_side_width,height]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_END_RAIL_WIDTH) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    square([width,rear_frame_end_width]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_CROSSBAR_WIDTH) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    translate([0,rear_crossbar_z[1]-rear_frame_crossbar_width/2])
                        square([width,rear_frame_crossbar_width]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_CROSSBAR_POSITIONS) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    for(zc=rear_crossbar_z)
                        translate([0,zc-rear_frame_crossbar_width/2])
                            square([width,rear_frame_crossbar_width]);

        // Bay opening construction
        } else if(view >= HUB75_P5_64X32_PANEL_VIEW_BAY_1 && view <= HUB75_P5_64X32_PANEL_VIEW_BAY_4) {
            _design_frame_context();
            _design_bay(view-HUB75_P5_64X32_PANEL_VIEW_BAY_1,false);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_BAY_ROUNDED_CORNER) {
            _design_frame_context();
            color(DESIGN_CUT)
                _rear_extrude_from_to(rear_frame_start_y-0.05,mounting_plane_y_value+0.3)
                    _rounded_rect_2d(
                        rear_frame_side_width,
                        opening_z_min[0],
                        width-2*rear_frame_side_width,
                        opening_z_max[0]-opening_z_min[0],
                        rear_opening_corner_radius
                    );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_BAY_BOTTOM_RELIEF) {
            _design_frame_context();
            color(DESIGN_CUT)
                _rear_extrude_from_to(rear_frame_start_y-0.05,mounting_plane_y_value+0.3)
                    _bay_end_relief_2d(opening_z_min[0],-1);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_BAY_TOP_RELIEF) {
            _design_frame_context();
            color(DESIGN_CUT)
                _rear_extrude_from_to(rear_frame_start_y-0.05,mounting_plane_y_value+0.3)
                    _bay_end_relief_2d(opening_z_max[0],1);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_OPENINGS) {
            _design_frame_context();
            color(DESIGN_CUT)
                _rear_extrude_from_to(rear_frame_start_y-0.05,mounting_plane_y_value+0.3)
                    _rear_openings_2d();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_WEB_SOLID) {
            _design_front_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    square([width,height]);

        // Resulting web/core and stepped end profile
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_WEB_CUT) {
            _design_front_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    _rear_frame_web_2d();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_FRAME_CORE) {
            // This is a completed structural state, not the current cutter.
            // Show the frame itself without the front stack hiding it.
            color(DESIGN_EXISTING)
                _rear_frame_core_3d();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_NARROW_END_WIDTH) {
            _design_frame_context();
            color(DESIGN_CUT)
                _design_thin_2d()
                    _bay_end_narrow_relief_2d(
                        opening_z_min[0],
                        -1
                    );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_NARROW_END_LENGTH) {
            _design_frame_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    translate([
                        width/2-rear_frame_end_narrow_length/2,
                        0
                    ])
                        square([
                            rear_frame_end_narrow_length,
                            rear_frame_end_width
                        ]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_NARROW_TRANSITION_LEFT) {
            _design_frame_context();
            color(DESIGN_CUT)
                _design_thin_2d()
                    _bay_end_transition_relief_2d(
                        opening_z_min[0],
                        -1,
                        "left"
                    );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_NARROW_TRANSITION_RIGHT) {
            _design_frame_context();
            color(DESIGN_CUT)
                _design_thin_2d()
                    _bay_end_transition_relief_2d(
                        opening_z_min[0],
                        -1,
                        "right"
                    );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_NARROW_PROFILE_COMPLETE) {
            _design_front_context();
            color(DESIGN_NEW)
                _design_thin_2d()
                    _rear_frame_web_2d();

        // Rear recess construction
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_RECESS_SIDE_LEFT) {
            _design_rear_context_base();
            _design_recess_part_3d()
                _rear_side_recess_2d("left");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_RECESS_SIDE_RIGHT) {
            _design_rear_context_base();
            _design_recess_part_3d()
                _rear_side_recess_2d("right");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_RECESS_BOTTOM) {
            _design_rear_context_base();
            _design_recess_part_3d()
                _rear_end_recess_2d("bottom");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_RECESS_TOP) {
            _design_rear_context_base();
            _design_recess_part_3d()
                _rear_end_recess_2d("top");

        } else if(view >= HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_1 && view <= HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_3) {
            _design_rear_context_base();
            _design_recess_part_3d()
                _rear_crossbar_recess_2d(view-HUB75_P5_64X32_PANEL_VIEW_RECESS_CROSSBAR_1);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_RECESS_BUSHING_PROTECTION) {
            _design_rear_context_base();
            color(DESIGN_NEW)
                _design_thin_2d()
                    _reinforcement_bushing_footprints_2d();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_RECESS_2D) {
            _design_rear_context_base();
            color(DESIGN_CUT)
                _design_thin_2d()
                    _rear_recess_2d();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_RECESS_3D) {
            _design_rear_context_base();
            _design_recess_part_3d()
                _rear_recess_2d();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_AFTER_RECESS) {
            color(DESIGN_EXISTING)
                _rear_frame_after_recess();

        // Mounting coordinates, tubes, reliefs and final holes
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_COLUMN_LEFT) {
            _design_rear_structure_context();
            _design_mounting_positions("left");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_COLUMN_RIGHT) {
            _design_rear_structure_context();
            _design_mounting_positions("right");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_BOTTOM) {
            _design_rear_structure_context();
            _design_mounting_positions("bottom");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_MIDDLE) {
            _design_rear_structure_context();
            _design_mounting_positions("middle");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_ROW_TOP) {
            _design_rear_structure_context();
            _design_mounting_positions("top");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_CENTRES) {
            _design_rear_structure_context();
            _design_mounting_positions("all");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBE_SINGLE) {
            _design_rear_context_after_mounting_reliefs();
            color(DESIGN_NEW)
                _mounting_tube(hole_x_positions[0],hole_z_positions[0]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBES) {
            _design_rear_context_after_mounting_reliefs();
            color(DESIGN_NEW)
                for(x=hole_x_positions)
                    for(z=hole_z_positions)
                        _mounting_tube(x,z);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_RELIEF_SINGLE) {
            _design_rear_context_after_recess();
            _design_mounting_relief(hole_x_positions[0],hole_z_positions[0]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_RELIEFS) {
            _design_rear_context_after_recess();
            for(x=hole_x_positions)
                for(z=hole_z_positions)
                    _design_mounting_relief(x,z);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_HOLE_SINGLE) {
            _design_full_context();
            _design_mounting_hole(hole_x_positions[0],hole_z_positions[0]);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_MOUNTING_HOLES) {
            _design_full_context();
            color(DESIGN_CUT)
                _mounting_hole_cutters();

        // Reinforcement bushing construction
        } else if(view >= HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BOTTOM_LEFT && view <= HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_TOP_RIGHT) {
            _design_rear_structure_context();
            _design_reinforcement_position(view-HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BOTTOM_LEFT);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_SOLIDS) {
            _design_frame_context();
            color(DESIGN_NEW)
                _reinforcement_bushing_solids();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_INNER_RECESS) {
            _design_rear_context_with_mounting_tubes();
            _design_reinforcement_inner_recess();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_BLIND_HOLE) {
            // Show the real state after the Ø10 recess so the deeper Ø2.5
            // cutter is visible instead of being hidden inside uncut material.
            _design_rear_context_after_reinforcement_inner_recess();
            _design_reinforcement_blind_hole();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REINFORCEMENT_FINISHED) {
            color(DESIGN_EXISTING)
                _rear_frame_after_reinforcement_cuts();

        // Locating pins
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_LOCATOR_UPPER_LEFT) {
            _design_rear_context_after_reinforcement_cuts();
            color(DESIGN_NEW)
                _locator_pin(
                    locator_pin_positions[0][0],
                    locator_pin_positions[0][1]
                );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_LOCATOR_LOWER_RIGHT) {
            _design_rear_context_after_reinforcement_cuts();
            color(DESIGN_NEW)
                _locator_pin(
                    locator_pin_positions[1][0],
                    locator_pin_positions[1][1]
                );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_LOCATOR_PINS) {
            _design_rear_context_after_reinforcement_cuts();
            color(DESIGN_NEW)
                for(pos=locator_pin_positions)
                    _locator_pin(pos[0],pos[1]);

        // Connectors and orientation
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTOR_BOTTOM) {
            _design_rear_structure_context();
            _design_connector_box(data_connector_z_bottom);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTOR_TOP) {
            _design_rear_structure_context();
            _design_connector_box(data_connector_z_top);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_DATA_CONNECTORS) {
            _design_rear_structure_context();
            _design_connector_box(data_connector_z_bottom);
            _design_connector_box(data_connector_z_top);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_POWER_CONNECTOR) {
            _design_rear_structure_context();
            _design_power_box();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_1) {
            _design_rear_structure_context();
            _design_arrow_marker(
                min(width-28,data_connector_x+38),
                data_connector_z_top,
                "down",
                0.42
            );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_2) {
            _design_rear_structure_context();
            _design_arrow_marker(
                20,
                (opening_z_min[2]+opening_z_max[2])/2,
                "right",
                0.50
            );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_BAY_4) {
            _design_rear_structure_context();
            _design_arrow_marker(
                min(width-28,data_connector_x+38),
                (opening_z_min[0]+opening_z_max[0])/2,
                "down",
                0.42
            );
            _design_arrow_marker(
                20,
                (opening_z_min[0]+opening_z_max[0])/2,
                "right",
                0.50
            );

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_ORIENTATION_ALL) {
            _design_rear_structure_context();
            _orientation_arrows();

        // Drawing verification broken into its three concepts
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_ENVELOPE) {
            _design_rear_structure_context();
            color(DESIGN_NEW)
                _design_thin_2d(mounting_plane_y_value+1.8)
                    difference() {
                        square([width,height]);
                        translate([1,1])
                            square([width-2,height-2]);
                    }

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_MOUNTING) {
            _design_rear_structure_context();
            _design_mounting_positions("all");

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_VERIFICATION_LOCATORS) {
            _design_rear_structure_context();
            color(DESIGN_NEW_SOLID)
                for(pos=locator_pin_positions)
                    translate([pos[0],mounting_plane_y_value+1.0,pos[1]])
                        rotate([-90,0,0])
                            cylinder(h=0.3,d=5,$fn=40);

        // Mating/profile/final checking views
        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_MATING_PLANE) {
            _design_full_context();
            _design_plane_y(mounting_plane_y_value, DESIGN_NEW);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_TAPER_PROFILE) {
            _design_x_section(0) {
                color(DESIGN_EXISTING)
                    _front_mask_shape();

                color(DESIGN_EXISTING)
                    _pcb_layer_shape();

                color(DESIGN_NEW)
                    _tapered_outer_blank(
                        rear_frame_start_y,
                        mounting_plane_y_value,
                        0,
                        rear_outer_inset_actual
                    );
            }

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_REAR_RAIL_PROFILE) {
            _design_x_section(
                -width/2 + rear_frame_side_width/2
            )
                _rear_frame_structure();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_CONNECTOR_CLEARANCE_PROFILE) {
            _design_x_section(0) {
                color(DESIGN_EXISTING)
                    _front_mask_shape();

                color(DESIGN_EXISTING)
                    _pcb_layer_shape();

                _rear_frame_structure();
            }

            _design_connector_box(data_connector_z_bottom);

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_FINAL_REAR) {
            _panel_final_local();

        } else if(view == HUB75_P5_64X32_PANEL_VIEW_FINAL_PROFILE) {
            _design_x_section(0)
                _panel_final_local();

        } else {
            assert(false,str("Unknown HUB75 design view id: ",view));
        }
    }


    // Keep all drawing / STEP dimensions above in their convenient
    // lower-left reference system, but expose the complete component centred
    // on X=0 and Z=0. The front face intentionally stays on Y=0.
    translate([-width/2, 0, -height/2])
        if(design_view >= HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE)
            _design_scene(design_view);
        else
            _panel_final_local();
}

// -----------------------------------------------------------------------------
// Standalone Customizer preview
// -----------------------------------------------------------------------------

/* [View] */
design_view = 0; // [0:Final panel, 1:Front, 2:Rear, 3:Rear structure, 4:Connectors, 5:PDF verification, 6:Profile]

/* [Preview] */
preview_color_scheme = "light_gray"; // [light_gray, original]

panel = hub75_p5_64x32_panel_create();

hub75_p5_64x32_panel_render(
    panel,
    view = design_view,
    color_scheme = preview_color_scheme
);
