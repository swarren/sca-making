/*
 * Copyright 2019-2021 Stephen Warren <swarren@wwwdotorg.org>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

$fn = 360 / 5;

epsilon = 0.001;

wood_thick = 6.25;

pcb_thick = 1.6;
pcb_width = 40;
pcb_height_nonslot = 75;
pcb_slot_width_top = 18;
pcb_slot_width_bottom = 18;
pcb_slot_height = 6;

pcb_usb_width = 8;
pcb_usb_height = 3.5;

battery_r = 18 / 2;

core_rod_width = wood_thick;
core_rod_thick = 5;
core_rod_height = (3 * wood_thick) + pcb_height_nonslot + (2 * wood_thick);
core_rod_xoff_center = (pcb_slot_width_bottom / 2) + (core_rod_width / 2) + 1;
core_pcb_yoff = 3;

switch_body_r = 12.5 / 2;
switch_end_r = 14 / 2;
switch_end_padded_r = switch_end_r + 1;
switch_yoff_center = 12;

core_r = 25;
core_tab_r = core_r + 5;
core_tab_w = 20;
core_clearance = 0.5;

led_mount_r = 44 / 2;
led_mount_clip_indent = 2;
led_mount_clip_r_outer = led_mount_r - led_mount_clip_indent;
led_mount_clip_r_delta = 2;
led_mount_clip_r_inner = led_mount_clip_r_outer - led_mount_clip_r_delta;
led_mount_clip_hole_w = 8;
led_mount_wire_angle = -45;
led_mount_wire_r = 2.5 / 2;
led_mount_wire_hole_len = 6;

body_r = 4.5 * 25.4 / 2;
body_height = 6 * 25.4;
body_rod_r = (1 / 4) * 25.4 / 2;
body_rod_placement_r = body_r - (body_rod_r + (0.3 * 25.4)); // 46.355
body_rope_r = (1 / 4) * 25.4 / 2;
body_rope_placement_r = body_r - (body_rope_r + (0.65 * 25.4));
body_window_width = 2 * ((body_rod_placement_r * sin(30)) - body_rod_r);
body_window_thick = 2;
//echo("Body window width:", window_width);

render_3d_layer_height_frac = 0.98;
col_wood = [222 / 255, 184 / 255, 135 / 255];
col_core_rod = [182 / 255, 144 / 255, 95 / 255];
col_body_rod = [182 / 255, 144 / 255, 95 / 255];
col_body_window = [0.9, 0.9, 0.9, 0.6];
col_pcb = [0, 0.75, 0];
col_bat = [0.5, 0.5, 1];
