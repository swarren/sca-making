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

include <core.scad>;

module body_cutout_rods() {
    for (a = [0:60:360]) {
        translate([body_rod_placement_r * cos(a), body_rod_placement_r * sin(a)])
            circle(r=body_rod_r);
    }
}

module body_cutout_ropes() {
    for (a = [0:180:180]) {
        translate([body_rope_placement_r * cos(a), body_rope_placement_r * sin(a)])
            circle(r=body_rope_r);
    }
}

module body_cutout_windows() {
    sx = body_rod_placement_r * cos(30);
    sy = body_rod_placement_r * sin(30);
    rh = sy * 2;
    for (a = [30:60:390]) {
        rotate(a)
            translate([sx, 0])
            square(size=[body_window_thick, rh], center=true);
    }
}

module body_layer_base() {
    circle(r=body_r);
}

module body_layer_1() {
    difference() {
        body_layer_base();
        body_cutout_rods();
        offset(delta=core_clearance) core_layer_2_positive();
    }
}

module body_layer_2_core_cutout() {
    for (a = [0:30:140]) {
        rotate(a) offset(delta=core_clearance) core_layer_2_positive();
    }
}

module body_layer_2() {
    difference() {
        body_layer_base();
        body_cutout_rods();
        body_layer_2_core_cutout();
    }
}

module body_layer_3() {
    difference() {
        body_layer_base();
        body_cutout_rods();
        body_cutout_windows();
        offset(delta=core_clearance) core_layer_3_positive();
    }
}

module body_layer_4() {
    difference() {
        body_layer_base();
        body_cutout_rods();
        body_cutout_ropes();
        body_cutout_windows();
    }
}

module body_layer_5() {
    difference() {
        body_layer_base();
        body_cutout_rods();
        body_cutout_ropes();
    }
}

module body_layer_6() {
    difference() {
        body_layer_base();
        body_cutout_ropes();
    }
}
