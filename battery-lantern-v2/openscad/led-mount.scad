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

$fn = 360;

mount_r = 43.9 / 2;
pcb_w = 0.6 * 25.4;
pcb_t = 1.6;
edge_cut_w = 6;
edge_cut_l = 10;
clip_cut_r_outer = mount_r - 2;
clip_cut_r_inner = clip_cut_r_outer - 2;
clip_hole_w = 8;

module ledmount_bottom() {
    difference() {
        circle(r=mount_r, center=true);
        translate([-pcb_w, -pcb_t])
            square(size=[pcb_w, pcb_t]);
        translate([mount_r - edge_cut_l, -edge_cut_w / 4])
            square(size=[edge_cut_l, edge_cut_w / 2]);
        translate([mount_r - (edge_cut_w / 2), 0])
            polygon([[0, 0], [edge_cut_w, edge_cut_w], [edge_cut_w, -edge_cut_w]]);
    }
}

module ledmount_top() {
    difference() {
        ledmount_bottom();
        intersection() {
            difference() {
                circle(r=clip_cut_r_outer, center=true);
                circle(r=clip_cut_r_inner, center=true);
            }
            for (angle = [-24, 24, 90, 180, 270]) {
                rotate(angle)
                    translate([clip_cut_r_inner - 5, -clip_hole_w / 2])
                    square(size=[10, clip_hole_w]);
            }
        }
    }
}

object_selector = 0; // Can be overridden on the cmdline

if (object_selector == 0) {
    spacing = mount_r * 2.25;
    ledmount_top();
    translate([spacing, 0]) ledmount_bottom();
} else if (object_selector == 1) {
    ledmount_top();
} else {
    ledmount_bottom();
}
