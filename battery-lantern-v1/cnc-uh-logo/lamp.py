#!/usr/bin/python3

import math
import sys

camotics = True
material_h = 0.75
disk_r = 2
bullnose_tool_r = 0.25 / 2
etch_tool_depth = 0.1
cylinder_tool_r = 0.25 / 2
safe_z = 0.25

def gcode_header():
    # XY plane
    print('G17')
    # Inches
    print('G20')
    # Absolute distance
    print('G90')
    # Absolute center mode
    # Invalid for MachCNC
    # Required for Camotics to match MachCNC's operation
    if camotics:
        print('G90.1')
    # Path blending tolerance 1/1000th inch
    print('G64 P0.001')
    # Spindle on
    print('M3')
    # Spindle speed
    print('S3000')
    # Coolant on
    print('M7')

def gcode_comment(s):
    print('( ' + s + ' )')

last_tool = None
def gcode_tool(tn):
    global last_tool
    if tn == last_tool:
        return
    last_tool = tn
    print('T%d M6' % tn)

def gcode_dwell(t=0.1):
    print('G4 P%0.3f' % t)
    pass

def _gcode_do_g1(x, y, z, f):
    gc = 'G1 G90'
    if x is not None:
        gc += ' X%1.3f' % x
    if y is not None:
        gc += ' Y%1.3f' % y
    if z is not None:
        gc += ' Z%1.3f' % z
    gc += ' F%d' % f
    print(gc)

def gcode_move_to(x=None, y=None, z=None, f=50):
    _gcode_do_g1(x, y, z, f)

def gcode_cut_to(x=None, y=None, z=None, f=15):
    _gcode_do_g1(x, y, z, f)

def gcode_circle_xy(cx, cy, f=50, cw=True):
    if cw:
        code = 2
    else:
        code = 3
    print('G%d I%0.3f J%0.3f F%d' % (code, cx, cy, f))

def home_safe_z():
    gcode_move_to(z=safe_z)
    gcode_move_to(x=0.0, y=0.0)

def gen_dowel_holes(cx, cy, xi, yi):
    gcode_comment('Dowel holes at %d, %d' % (xi, yi))
    gcode_tool(2)
    nholes = 6
    hole_pos_r = disk_r * 0.7
    for a in range(30, 360, 60):
        a = math.radians(a)
        x = cx + (hole_pos_r * math.cos(a))
        y = cy + (hole_pos_r * math.sin(a))
        gcode_move_to(z=safe_z)
        gcode_move_to(x=x, y=y)
        gcode_cut_to(z=-etch_tool_depth/2)
        gcode_dwell(0.1)
        gcode_move_to(z=safe_z)

def gen_top_uh_logo(cx, cy, xi, yi):
    gcode_comment('UH logo at %d, %d' % (xi, yi))
    gcode_tool(2)
    gcode_move_to(z=safe_z)
    scale = 0.75
    tri_scale = 0.1
    gcode_comment('  Vertical lines')
    for xp in (-2, -1, 0, 1, 2):
        gcode_comment('    Vertical line %d' % xp)
        off = xp * (scale / 2)
        gcode_move_to(x=cx+off, y=cy+scale)
        gcode_cut_to(z=-etch_tool_depth)
        gcode_cut_to(x=cx+off, y=cy-scale)
        gcode_cut_to(x=cx+off-tri_scale, y=cy-scale)
        gcode_cut_to(x=cx+off, y=cy-scale-tri_scale)
        gcode_cut_to(x=cx+off+tri_scale, y=cy-scale)
        gcode_cut_to(x=cx+off, y=cy-scale)
        gcode_move_to(z=safe_z)
    gcode_comment('  Horizontal lines')
    for yp in (-1, 0, 1, 2):
        gcode_comment('    Horizontal line %d' % yp)
        off = yp * (scale / 2)
        gcode_move_to(x=cx-scale, y=cy+off)
        gcode_cut_to(z=-etch_tool_depth)
        gcode_cut_to(x=cx+scale, y=cy+off)
        gcode_move_to(z=safe_z)

def gen_top_rope_holes(cx, cy, xi, yi):
    gcode_comment('Rope holes at %d, %d' % (xi, yi))
    gcode_tool(2)
    hole_pos_r = disk_r * 0.55
    for a in (0, 180):
        a = math.radians(a)
        x = cx + (hole_pos_r * math.cos(a))
        y = cy + (hole_pos_r * math.sin(a))
        gcode_move_to(z=safe_z)
        gcode_move_to(x=x, y=y)
        gcode_cut_to(z=-etch_tool_depth/2)
        gcode_move_to(z=safe_z)

def gen_top(cx, cy, xi, yi):
    gen_dowel_holes(cx, cy, xi, yi)
    gen_top_uh_logo(cx, cy, xi, yi)
    gen_top_rope_holes(cx, cy, xi, yi)

def gen_switch_mount(cx, cy, xi, yi):
    gcode_comment('Switch mount at %d, %d' % (xi, yi))
    gcode_tool(4)
    x_offset = 9.0 / 16
    gcode_move_to(z=safe_z)
    gcode_move_to(x=cx, y=cy)
    for (depth, diameter) in (
            (0.1, 0.75),
            (0.2, 0.75),
            (0.3, 0.75),
            (0.4, 0.75),
            (0.5, 0.75),
            (0.6, 0.75),
            (0.7, 0.5),
            (0.8, 0.5),
        ):
        radius = diameter / 2
        gcode_move_to(x=cx + radius - cylinder_tool_r + x_offset, y=cy, f=10)
        gcode_cut_to(z=-depth, f=10)
        while radius > cylinder_tool_r:
            corrected_r = radius - cylinder_tool_r
            gcode_cut_to(x=cx + corrected_r + x_offset, y=cy, f=10)
            gcode_circle_xy(cx + x_offset, cy, f=10)
            radius -= cylinder_tool_r

def gen_bottom(cx, cy, xi, yi):
    gen_switch_mount(cx, cy, xi, yi)
    #gen_dowel_holes(cx, cy, xi, yi)

def gen_jig_hole(cx, cy, xi, yi):
    gcode_comment('Jig hole at %d, %d' % (xi, yi))
    tolerance_r = 0.075
    gcode_move_to(z=safe_z)
    gcode_move_to(x=cx + disk_r - cylinder_tool_r + tolerance_r, y=cy)
    for depth in [-0.25, -0.55]:
        gcode_cut_to(z=depth)
        gcode_circle_xy(cx, cy)
    gcode_move_to(z=safe_z)

def gen_layout(func):
    countx = 5
    county = 1
    margin = 0.5
    ofs_init = disk_r + margin
    ofs_incr = (disk_r * 2) + margin
    hole_r = disk_r + cylinder_tool_r
    for yi in range(county):
        cy = ofs_init + (yi * ofs_incr)
        xis = [x for x in range(countx)]
        if yi % 2:
            xis.reverse()
        for xi in xis:
            cx = ofs_init + (xi * ofs_incr)
            func(cx, cy, xi, yi)

def gcode_trailer():
    # Coolant off
    print('M9')
    # Spindle stop
    print('M5')
    # End program
    print('M02')

with open('lamp.nc', 'wt') as f:
    sys.stdout = f
    gcode_header()
    home_safe_z()
    #gen_layout(gen_top)
    gen_layout(gen_bottom)
    #gen_layout(gen_jig_hole)
    # Test?
    if False:
        gen_all_top(2, 2, 0, 0)
        gcode_move_to(z=safe_z)
        gcode_move_to(x=4, y=2)
        gcode_move_to(z=-etch_tool_depth)
        gcode_circle_xy(2, 2)
        gcode_move_to(z=safe_z)
    home_safe_z()
    gcode_trailer()
