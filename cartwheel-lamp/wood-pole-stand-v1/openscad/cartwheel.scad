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

$fa = 5;

// Parameters; edit these
wall_w = 5;
//rim_outer_d = 550; // Original size; large LASER cutter
rim_outer_d = 380; // Small size; CAM5 LASER cutter
rim_w = 25;
spoke_w = 25;
hub_outer_d = 152;
lamp_outer_d = 81;
lampholder_d = 29.5;
lampholder_tab_l = 31.5;
lampholder_tab_w = 5;
pole_ws = [
  65, // Larger hole in cartwheel itself
  63.5, // Smaller hole for support on Panther pavilion main pole
  53, // Smaller hole for support on Panther pavilion corner poles
];
pole_hs = [
  50, // Larger hole in cartwheel itself
  36, // Smaller hole for support on Panther pavilion main pole
  36, // Smaller hole for support on Panther pavilion corner poles
];
pole_size_selector = 0; // Can be overridden on the cmdline
pole_w = pole_ws[pole_size_selector];
pole_h = pole_hs[pole_size_selector];

// Calculated; don't change these
rim_outer_r = 0.5 * rim_outer_d;
rim_inner_d = rim_outer_d - (2 * rim_w);
rim_inner_r = 0.5 * rim_inner_d;
rim_mid_w = 0.5 * rim_w;
rim_mid_d = rim_outer_d - (2 * rim_mid_w);
rim_mid_r = 0.5 * rim_mid_d;
spoke_channel_w = spoke_w - (2 * wall_w);
hub_outer_r = 0.5 * hub_outer_d;
hub_inner_d = hub_outer_d - (2 * wall_w);
hub_inner_r = 0.5 * hub_inner_d;
lamp_outer_r = 0.5 * lamp_outer_d;
lamp_mid_d = lamp_outer_d - (2 * wall_w);
lamp_mid_r = 0.5 * lamp_mid_d;
lamp_inner_d = lamp_mid_d - (2 * wall_w);
lamp_inner_r = 0.5 * lamp_inner_d;
lampholder_r = 0.5 * lampholder_d;
pole_ring_w = pole_w + (2 * wall_w);
pole_ring_h = pole_h + (2 * wall_w);

module lamp_cutout() {
    circle(center=true, r=lampholder_r);
    square(size=[lampholder_tab_l, lampholder_tab_w], center=true);
    square(size=[lampholder_tab_w, lampholder_tab_l], center=true);
}

module lamp_surround_outer() {
    circle(center=true, r=lamp_outer_r);
}

module lamp_surround_mid() {
    circle(center=true, r=lamp_mid_r);
}

module lamp_surround_inner() {
    circle(center=true, r=lamp_inner_r);
}

module lamp_surround() {
    difference() {
        lamp_surround_outer();
        lamp_surround_mid();
    }
    lamp_surround_inner();
    intersection() {
        lamp_surround_outer();
        square([lamp_outer_d, spoke_w], center=true);
    }
}

module lamp_ring() {
    difference() {
        lamp_surround_outer();
        lamp_surround_mid();
    }
}

module rim_outer() {
    circle(r=rim_outer_r, center=true);
}

module rim_inner() {
    circle(r=rim_inner_r, center=true);
}

module hub_outer() {
    circle(r=hub_outer_r, center=true);
}

module hub_inner() {
    circle(r=hub_inner_r, center=true);
}

module round_rect(w, h, r) {
    hull()
        for (x = [-1:2:1])
            for (y = [-1:2:1])
                translate([x * (0.5 * w - r), y * (0.5 * h - r), 0])
                    circle(r=r, center=true);
}

module pole_outer() {
    round_rect(pole_ring_w, pole_ring_h, wall_w * 1.5);
}

module pole_inner() {
    round_rect(pole_w, pole_h, wall_w);
}

module pole_ring() {
    difference() {
        pole_outer();
        pole_inner();
    }
}

module hub_layer() {
    difference() {
        hub_outer();
        pole_inner();
    }
}

module spoke_outer() {
    square(size=[rim_mid_d, spoke_w], center=true);
}

module spoke_inner() {
    square(size=[rim_mid_r, spoke_channel_w], center=true);
}

module layer1() {
    difference() {
        union() {
            difference() {
                rim_outer();
                rim_inner();
            }
            hub_outer();
            for (i = [0:2:5]) {
                rotate([0, 0, i * 360 / 6]) {
                    spoke_outer();
                    translate([rim_mid_r, 0]) lamp_surround();
                }
            }
        }
        hub_inner();
    }
}

module layer2() {
    difference() {
        layer1();
        for (i = [0:2:5]) {
            rotate([0, 0, i * 360 / 6]) {
                translate([0.5 * rim_mid_r, 0, 0])
                    spoke_inner();
                translate([rim_mid_r, 0]) lamp_cutout();
            }
        }
    }
}

module layer3() {
    difference() {
        layer1();
        for (i = [0:2:5]) {
            rotate([0, 0, i * 360 / 6]) {
                translate([rim_mid_r, 0]) lamp_cutout();
            }
        }
    }
}

object_selector = 0; // Can be overridden on the cmdline
if (object_selector == 0) {
    translate([-750, 0, 0]) layer1();
    layer2();
    translate([750, 0, 0]) layer3();
    translate([-750, 500, 0]) hub_layer();
    translate([0, 500, 0]) lamp_ring();
    translate([750, 500, 0]) pole_ring();
} else if (object_selector == 1) {
    layer1();
} else if (object_selector == 2) {
    layer2();
} else if (object_selector == 3) {
    layer3();
} else if (object_selector == 4) {
    hub_layer();
} else if (object_selector == 5) {
    lamp_ring();
} else if (object_selector == 6) {
    pole_ring();
}
