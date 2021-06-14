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

include <body.scad>;
include <constants.scad>;
include <core.scad>;

module battery() {
    cylinder(d=18, h=65, center=true);
}

module pcb_board() {
    linear_extrude(pcb_thick) {
        square([pcb_width, pcb_height_nonslot], center=true);
        translate([0, (pcb_height_nonslot + pcb_slot_height) / 2])
            square([pcb_slot_width_top, pcb_slot_height + epsilon], center=true);
        translate([0, -(pcb_height_nonslot + pcb_slot_height) / 2])
            square([pcb_slot_width_bottom, pcb_slot_height + epsilon], center=true);
    }
}

module pcb() {
    color(col_pcb) pcb_board();
    color(col_bat) translate([0, 0, -battery_r]) rotate([90, 0, 0]) battery();
}

module core_rod_3d() {
    linear_extrude(core_rod_height) core_rod();
}

module core_rods_3d() {
    yoff = (pcb_thick / 2) + (core_rod_thick / 2);
    translate([core_rod_xoff_center, core_pcb_yoff + yoff, 0]) core_rod_3d();
    translate([core_rod_xoff_center, core_pcb_yoff - yoff, 0]) core_rod_3d();
}

module render_core() {
    color(col_wood)
        translate([0, 0, 0])
        linear_extrude(wood_thick * render_3d_layer_height_frac) core_layer_1();
    color(col_wood)
        translate([0, 0, wood_thick])
        linear_extrude(wood_thick * render_3d_layer_height_frac) core_layer_2();
    color(col_wood)
        translate([0, 0, 2 * wood_thick])
        linear_extrude(wood_thick * render_3d_layer_height_frac) core_layer_3();
    translate([0, core_pcb_yoff + (pcb_thick / 2), (3 * wood_thick) + (pcb_height_nonslot / 2)])
        rotate([90, 0, 0])
        pcb();
    color(col_wood)
        translate([0, 0, 75 + 3 * wood_thick])
        linear_extrude(wood_thick * render_3d_layer_height_frac) core_layer_led_bottom();
    color(col_wood)
        translate([0, 0, 75 + 4 * wood_thick])
        linear_extrude(wood_thick * render_3d_layer_height_frac) core_layer_led_top();
    color(col_core_rod) core_rods_3d();
}

module body_rod_3d() {
    translate([0, 0, body_height / 2])
        cylinder(d=(body_rod_r * 2), h=(body_height - wood_thick), center=true);
}

module body_rods_3d() {
    for (a = [0:60:360]) {
        translate([body_rod_placement_r * cos(a), body_rod_placement_r * sin(a), -wood_thick / 2])
            body_rod_3d();
    }
}

module body_window_3d() {
    body_window_height = body_height - (4 * wood_thick);
    translate([0, 0, body_height / 2])
        cube([body_window_thick, body_window_width, body_window_height], center=true);
}

module body_windows_3d() {
    sx = body_rod_placement_r * cos(30);
    sy = body_rod_placement_r * sin(30);
    rh = sy * 2;
    for (a = [30:60:390]) {
        rotate(a)
            translate([sx, 0])
            body_window_3d();
    }
}

module render_body() {
    color(col_wood)
        translate([0, 0, 0])
        linear_extrude(wood_thick * render_3d_layer_height_frac)
        body_layer_1();
    color(col_wood)
        translate([0, 0, wood_thick])
        linear_extrude(wood_thick * render_3d_layer_height_frac)
        body_layer_2();
    color(col_wood)
        translate([0, 0, 2 * wood_thick])
        linear_extrude(wood_thick * render_3d_layer_height_frac)
        body_layer_3();
    color(col_wood)
        translate([0, 0, body_height - (3 * wood_thick)])
        linear_extrude(wood_thick * render_3d_layer_height_frac)
        body_layer_4();
    color(col_wood)
        translate([0, 0, body_height - (2 * wood_thick)])
        linear_extrude(wood_thick * render_3d_layer_height_frac)
        body_layer_5();
    color(col_wood)
        translate([0, 0, body_height - (1 * wood_thick)])
        linear_extrude(wood_thick * render_3d_layer_height_frac)
        body_layer_6();
    color(col_body_rod)
        body_rods_3d();
    color(col_body_window)
        body_windows_3d();
}

translate([-(body_r + (2 * core_r)) , 0, 0])
    rotate([0, 0, 180]) 
    render_core();

render_body();

translate([(body_r * 2) + core_r, 0, 0]) {
    rotate([0, 0, 120]) render_core();
    render_body();
}
