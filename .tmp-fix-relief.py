from pathlib import Path

path = Path('openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad')
text = path.read_text()
old = '''    module _bay_end_relief_2d(z_edge, direction=1) {\n        union() {\n            _bay_end_transition_relief_2d(z_edge, direction, "left");\n            _bay_end_narrow_relief_2d(z_edge, direction);\n            _bay_end_transition_relief_2d(z_edge, direction, "right");\n        }\n    }\n'''
new = '''    module _bay_end_relief_2d(z_edge, direction=1) {\n        d = rear_frame_end_step_depth;\n        half_narrow = rear_frame_end_narrow_length/2;\n        cx = width/2;\n        join_overlap = 0.05;\n\n        // Production cutter is one polygon with a tiny overlap into the\n        // already-open bay. The visible STEP-derived contour is unchanged;\n        // the overlap only prevents an edge-touch seam from surviving as an\n        // internal vertical wall when the 2D opening is extruded.\n        if(d > 0)\n            polygon([\n                [cx-half_narrow-d, z_edge - direction*join_overlap],\n                [cx-half_narrow,   z_edge + direction*d],\n                [cx+half_narrow,   z_edge + direction*d],\n                [cx+half_narrow+d, z_edge - direction*join_overlap]\n            ]);\n    }\n'''
if old not in text:
    raise SystemExit('target relief helper not found')
path.write_text(text.replace(old, new, 1))
