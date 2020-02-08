/*
 * Copyright 2020 Stephen Warren <swarren@wwwdotorg.org>
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

include <led-mount.scad>;
include <lantern.scad>;

object_selector = -1;

module item(y, x) {
    if (y == 0) {
        if (x != 0) {
            layer_top_3();
        }
    } else {
        if (x == 0) {
            layer_1_lamp();
            layer_1_insert();
        } else if (x == 1) {
            layer_2_lamp();
            layer_2_insert();
            translate([outer_r, -outer_r]) led_mount_bottom();
        } else if (x == 2) {
            layer_3_lamp();
            layer_3_insert();
            translate([outer_r, -outer_r]) led_mount_top();
        } else if (x == 3) {
            layer_top_1();
        } else if (x == 4) {
            layer_top_2();
        }
    }
}

for (y = [0:4]) {
    for (x = [0:4]) {
        translate([x * 2 * (outer_r + 0.5), y * 2 * (outer_r + 0.5)])
            item(y, x);
    }
}

for (y = [1:4]) {
    translate([-outer_r * 2, y * 2 * (outer_r + 0.5)])
        layer_2_tabs_scored();
}
