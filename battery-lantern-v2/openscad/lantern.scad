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
outer_r = 4.5 * 25.4 / 2;
rod_r = (1 / 4) * 25.4 / 2;
rod_placement_r = outer_r - (rod_r + (0.3 * 25.4));
load_hole_r = 25;
tab_r = load_hole_r + 5;
tab_w = 20;
rope_r = (1 / 4) * 25.4 / 2;
rope_placement_r = outer_r - (rope_r + (0.65 * 25.4));
sheet_thick = 2;

window_width = 2 * ((rod_placement_r * sin(30)) - rod_r);
echo("Window width:", window_width); // 33.655

module sheet_cutouts() {
    sx = rod_placement_r * cos(30);
    sy = rod_placement_r * sin(30);
    rh = sy * 2;
    for (a = [0:60:360]) {
        rotate(a)
            translate([sx, 0])
            square(size=[sheet_thick, rh], center=true);
    }
};

module basic_layer() {
    difference() {
        circle(r=outer_r);

        for (a = [30:60:390]) {
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
        sheet_cutouts();
    }
}

module layer_2_tabs() {
    intersection() {
        circle(r=tab_r, center=true);
        square(size=[tab_r * 3, tab_w], center=true);
    }
}

module layer_2_insert() {
    difference() {
        union() {
            circle(r=load_hole_r, center=true);
            layer_2_tabs();
        }
        switch_hole_nut(false);
    }
}

module layer_2_tabs_scored() {
    difference() {
        layer_2_tabs();
        circle(r=load_hole_r, center=true);
    }
}

module layer_2_cutout() {
    difference() {
        offset(delta=1)
            circle(r=tab_r, center=true);
        difference() {
            rotate(40)
                offset(delta=2)
                layer_2_insert();
            rotate(60)
                offset(delta=2)
                layer_2_insert();
            offset(delta=1)
                layer_2_insert();
            offset(delta=1) layer_1_insert();
        }
    }
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

module rope_holes() {
    for (a = [0:180:180]) {
        translate([rope_placement_r * cos(a + 30), rope_placement_r * sin(a + 30)])
            circle(r=rope_r, center=true);
    }
}

module basic_layer_top() {
    difference() {
        basic_layer();
        rope_holes();
    }
}

module layer_top_1() {
    basic_layer_top();
}

module layer_top_2() {
    basic_layer_top();
}

module layer_top_3() {
    difference() {
        basic_layer_top();
        sheet_cutouts();
    }
}

module top() {
  if (array) {
    for (y = [0:4]) {
        for (x = [0:4]) {
            translate([x * 2 * (outer_r + 1), y * 2 * (outer_r + 1)])
              children(0);
        }
    }
  } else {  
    children(0);
  }
}

object_selector = 0; // Can be overridden on the cmdline
array = 0; // Can be overridden on the cmdline

top() {
    if (object_selector == -1) {
    } else if (object_selector == 0) {
        spacing = outer_r * 2.25;

        translate([1 * spacing, -0.75 * spacing, 0]) layer_2_tabs_scored();

        translate([0 * spacing, 0, 0]) layer_1_lamp();
        translate([1 * spacing, 0, 0]) layer_2_lamp();
        translate([2 * spacing, 0, 0]) layer_3_lamp();

        translate([0 * spacing, 0, 0]) layer_1_insert();
        translate([1 * spacing, 0, 0]) layer_2_insert();
        translate([2 * spacing, 0, 0]) layer_3_insert();

        translate([0 * spacing, 1 * spacing, 0]) layer_top_1();
        translate([1 * spacing, 1 * spacing, 0]) layer_top_2();
        translate([2 * spacing, 1 * spacing, 0]) layer_top_3();
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
        layer_top_1();
    } else if (object_selector == 5) {
        layer_top_2();
    } else if (object_selector == 6) {
        layer_top_3();
    } else if (object_selector == 7) {
        layer_2_tabs_scored();
    }
}
