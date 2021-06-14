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

include <constants.scad>;

module core_cutout_pcb_top() {
    square(size=[pcb_slot_width_top, pcb_thick], center=true);
}

module core_cutout_pcb_bottom() {
    square(size=[pcb_slot_width_bottom, pcb_thick], center=true);
    translate([0, -((pcb_usb_height / 2) + (pcb_thick / 2)) + epsilon])
        square(size=[pcb_usb_width, pcb_usb_height], center=true);
}

module core_rod() {
    square(size=[core_rod_width, core_rod_thick], center=true);
}

module core_cutout_rods() {
    yoff = (pcb_thick / 2) + (core_rod_thick / 2);
    translate([core_rod_xoff_center,  yoff]) core_rod();
    translate([core_rod_xoff_center, -yoff]) core_rod();
}

module core_cutout_switch_body() {
    translate([0, -switch_yoff_center])
        circle(r=switch_body_r);
}

module core_cutout_finger_slot() {
    hull() {
        translate([0, switch_yoff_center])
            circle(r=switch_end_padded_r);
        translate([0, -switch_yoff_center])
            circle(r=switch_end_padded_r);
    }
}

module core_cutout_clips() {
    intersection() {
        difference() {
            circle(r=led_mount_clip_r_outer);
            circle(r=led_mount_clip_r_inner);
        }
        led_mount_clip_r_mid = (led_mount_clip_r_inner + led_mount_clip_r_outer) / 2;
        // 29.5, 72.5, 115.5, 158.5, 201.5, 244.4, 287.4, 330.4
        for (angle = [29.5, 115.5, 244.4, 330.4]) {
            rotate(angle)
                translate([led_mount_clip_r_mid, 0])
                square(size=[led_mount_clip_r_delta * 2, led_mount_clip_hole_w], center=true);
        }
    }
}

module core_cutout_wire() {
    manual_alignment_compensation = 0.15;
    translate([led_mount_r - led_mount_wire_hole_len - manual_alignment_compensation, 0]) {
        circle(r=led_mount_wire_r);
        difference() {
            translate([0, -led_mount_wire_r * 2])
                square(size=[led_mount_wire_hole_len * 2, led_mount_wire_r * 4], center=false);
            for (ymult= [-1, 1]) {
                hull() {
                    translate([0, led_mount_wire_r * 2 * ymult])
                        circle(r=led_mount_wire_r);
                    translate([led_mount_wire_hole_len - led_mount_wire_r, led_mount_wire_r * 2 * ymult])
                        circle(r=led_mount_wire_r);
                }
            }
        }
    }
}

module core_body() {
    circle(r=core_r);
}

module core_layer_1_positive() {
    core_body();
}

module core_layer_1_negative() {
    core_cutout_finger_slot();
    translate([0, core_pcb_yoff]) {
        core_cutout_rods();
    }
}

module core_layer_1() {
    difference() {
        core_layer_1_positive();
        core_layer_1_negative();
    }
}

module core_layer_2_tabs() {
    intersection() {
        circle(r=core_tab_r);
        square(size=[core_tab_w, core_tab_r * 3], center=true);
    }
}

module core_layer_2_positive() {
    core_body();
    core_layer_2_tabs();
}

module core_layer_2_negative() {
    core_cutout_finger_slot();
    translate([0, core_pcb_yoff]) {
        core_cutout_rods();
    }
}

module core_layer_2() {
    difference() {
        core_layer_2_positive();
        core_layer_2_negative();
    }
}

module core_layer_2_engrave() {
    difference() {
        core_layer_2_positive();
        offset(delta=epsilon) core_body();
    }
}

module core_layer_3_negative() {
    translate([0, core_pcb_yoff]) {
        core_cutout_pcb_bottom();
        core_cutout_rods();
    }
    core_cutout_switch_body();
}

module core_layer_3_positive() {
        core_body();
}

module core_layer_3() {
    difference() {
        core_layer_3_positive();
        core_layer_3_negative();
    }
}

module core_layer_led_bottom() {
    difference() {
        circle(r=led_mount_r);
        translate([0, core_pcb_yoff]) {
            core_cutout_pcb_top();
            core_cutout_rods();
        }
        rotate(led_mount_wire_angle) {
            core_cutout_wire();
        }
    }
}

module core_layer_led_top() {
    difference() {
        circle(r=led_mount_r);
        translate([0, core_pcb_yoff]) {
            core_cutout_rods();
        }
        rotate(led_mount_wire_angle) {
            core_cutout_clips();
            core_cutout_wire();
        }
    }
}
