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

$fn=72;
outer_r = 4 * 25.4 / 2;
rod_r = (3 / 16) * 25.4 / 2;
rod_placement_r = outer_r - (rod_r + (0.5 * 25.4));
load_hole_r = 25;
tab_r = load_hole_r + 5;
tab_w = 20;

module basic_layer() {
    difference() {
        circle(r=outer_r);

        for (a = [0:60:360]) {
            translate([rod_placement_r * cos(a), rod_placement_r * sin(a)])
                circle(r=rod_r, center=true);
        }
    }
}

module battery_pack_outline() {
    rotate(135) {
        translate([-15, -15]) {
            square(size=[32, 15], center=false);
            square(size=[15, 28], center=false);
        }
    }
}

module switch_hole_xlate(both) {
    translate([-12, 0])
        children();
    if (both) {
        translate([12, 0])
            children();
    }
}

module switch_hole_body() {
    switch_hole_xlate(false)
        circle(r=0.5 * 25.4 / 2, center=true);
};

module switch_hole_nut(both) {
    switch_hole_xlate(both)
        circle(r=0.75 * 25.4 / 2, center=true);
};

module load_hole() {
    circle(r=load_hole_r, center=true);
}

module layer_1_insert() {
    difference() {
        circle(r=load_hole_r, center=true);
        switch_hole_body();
        // Uncomment just to check alignment; not manufacturing
        //#battery_pack_outline();
    }
}

module layer_1_cutout() {
    offset(delta=1) layer_1_insert();
}

module layer_1_lamp() {
    difference() {
        basic_layer();
        load_hole();
        layer_1_cutout();
    }
}

module layer_2_insert() {
    difference() {
        union() {
            circle(r=load_hole_r, center=true);
            intersection() {
                circle(r=tab_r, center=true);
                square(size=[tab_r * 3, tab_w], center=true);
            }
        }
        switch_hole_nut(false);
    }
}

module layer_2_cutout() {
    offset(delta=1)
        circle(r=tab_r, center=true);
}

module layer_2_lamp() {
    difference() {
        basic_layer();
        load_hole();
        layer_2_cutout();
    }
}

module layer_3_insert() {
    difference() {
        circle(r=load_hole_r, center=true);
        switch_hole_nut(true);
    }
}

module layer_3_cutout() {
    offset(delta=1) layer_2_insert();
}

module layer_3_lamp() {
    difference() {
        basic_layer();
        load_hole();
        layer_3_cutout();
    }
}

module layer_top() {
    basic_layer();
}

object_selector = 0; // Can be overridden on the cmdline
if (object_selector == 0) {
    spacing = outer_r * 2.25;

    translate([0 * spacing, 0, 0]) layer_1_lamp();
    translate([1 * spacing, 0, 0]) layer_2_lamp();
    translate([2 * spacing, 0, 0]) layer_3_lamp();

    translate([0 * spacing, 0, 0]) layer_1_insert();
    translate([1 * spacing, 0, 0]) layer_2_insert();
    translate([2 * spacing, 0, 0]) layer_3_insert();

    translate([0 * spacing, 1 * spacing, 0]) layer_top();
} else if (object_selector == 1) {
    layer_1_lamp();
    layer_1_insert();
} else if (object_selector == 2) {
    layer_2_lamp();
    layer_2_insert();
} else if (object_selector == 3) {
    layer_3_lamp();
    layer_3_insert();
} else if (object_selector == 4) {
    layer_top();
}
