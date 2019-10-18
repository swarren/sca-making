/*
 * Copyright 2019 Stephen Warren <swarren@wwwdotorg.org>
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

len_8_leds = 137;
outer_r = len_8_leds / (2 * PI);
mount_w = 16;
//mount_thick = 2; // Mounted onto PCB
mount_thick = 1/4 * 25.4; // Mounted onto 1/4" wood piece
base_thick = 2;
wall_w = 2;
wire_hole_r = 3;
led_h = 10;
total_h = base_thick + led_h;

module wedge(r, a0, a1) {
  points = [
    [0, 0],
    [r * cos(a0), r * sin(a0)],
    [r * cos(a1), r * sin(a1)],
  ];
  paths = [
    [0, 1, 2]
  ];
  polygon(points, paths, 0);
}

module thick_arc_cutout(r0, r1, a0, a1) {
    difference() {
        circle(center=true, r=r1);
        circle(center=true, r=r0);
        wedge(2 * r1, a0, a1);
    }
}

module thick_arc_acute(r0, r1, a0, a1) {
    intersection() {
        difference() {
            circle(center=true, r=r1);
            circle(center=true, r=r0);
        }
        wedge(2 * r1, a0, a1);
    }
}

difference() {
    union() {
        linear_extrude(height=base_thick)
            circle(center=true, r=outer_r + 1);
        linear_extrude(height=total_h) {
            thick_arc_cutout(outer_r - wall_w, outer_r, 0, 30);
            translate([outer_r - wall_w - 6, 0, 0])
                thick_arc_acute(6, 8, 0, 90);
            translate([-(mount_w + wall_w), -(mount_thick + wall_w), 0])
                square(size=[mount_w + 4, mount_thick + 4], center=false);
        }
    }
    translate([-mount_w, -mount_thick, -1])
        linear_extrude(height=9)
        square(size=[mount_w, mount_thick], center=false);
    translate([-wire_hole_r, -(mount_thick + wall_w + 1 + wire_hole_r), 0])
        cylinder(r=wire_hole_r, h=total_h, center=true);
}
