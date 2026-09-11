from pathlib import Path

path = Path('openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad')
text = path.read_text()
old = '''    module _rear_frame_core_3d() {\n        // Extrude the already-cut 2D frame web with vertical bay walls, then\n        // clip only its outside perimeter with the tapered rear envelope.\n        // This is geometrically equivalent to subtracting the four vertical\n        // bay cutters, without the triangular Boolean remnants.\n        intersection() {\n            _tapered_outer_blank(\n                rear_frame_start_y,\n                mounting_plane_y_value,\n                0,\n                rear_outer_inset_actual\n            );\n\n            _rear_extrude_from_to(\n                rear_frame_start_y - 0.05,\n                mounting_plane_y_value + 0.05\n            )\n                _rear_frame_web_2d();\n        }\n    }\n'''
new = '''    module _rear_frame_core_3d() {\n        difference() {\n            // The outside wall tapers continuously from the rear-housing\n            // start to the mounting plane. The bay cutters remain vertical.\n            _tapered_outer_blank(\n                rear_frame_start_y,\n                mounting_plane_y_value,\n                0,\n                rear_outer_inset_actual\n            );\n\n            _rear_extrude_from_to(\n                rear_frame_start_y - 0.05,\n                mounting_plane_y_value + 0.05\n            )\n                _rear_openings_2d();\n        }\n    }\n'''
if old not in text:
    raise SystemExit('current intersection core helper not found')
path.write_text(text.replace(old, new, 1))
