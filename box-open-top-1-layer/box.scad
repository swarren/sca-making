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

// TODO: Kerf correction
// TODO: Use accurate wood thickness

wood_thickness = 6.4;
box_w = 10.5 * 25.4;
box_d = 10.5 * 25.4;
box_h = 10.5 * 25.4;
tab_unit = 6;
handle_r = 25.4 / 2;
handle_c_sep = 25.4 * 2.5;
handle_h_off = 25.4;
support_t = 25.4 * 0.5;
support_w = box_w - (2 * wood_thickness);
support_d = box_d - (2 * wood_thickness);

epsilon = 0.01;
half_epsilon = epsilon / 2;

function is_odd(val) = abs(val) % 2;
function floor_odd(val) = (floor(val) % 2) ? floor(val) : (floor(val) - 1);

function tabbed_width(dx) = dx - (4 * wood_thickness);
function tab_chunk_count(dx) = floor_odd(tabbed_width(dx) / (tab_unit * 3));

module edge_cutouts(dx, offset_tabs, clear_inner) {
    tcc = tab_chunk_count(dx);
    tcc_per_side = (tcc - 1) / 2;

    clear_width_inner = ((dx - (tcc * 3 * tab_unit)) / 2) + (offset_tabs ? 0 : epsilon);
    xlate_inner = (dx / 2) - (clear_width_inner / 2);

    if (clear_inner)
        translate([-xlate_inner - half_epsilon, half_epsilon, 0])
            cube([clear_width_inner + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
    for (xp = [-tcc_per_side:1:tcc_per_side]) {
        translate([xp * 3 * tab_unit, 0, 0]) {
            if (is_odd(xp) == offset_tabs) {
                translate([0, half_epsilon, 0])
                    cube([tab_unit * 3, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
            }
        }
    }
    if (clear_inner)
        translate([xlate_inner + half_epsilon, half_epsilon, 0])
            cube([clear_width_inner + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
}

module side_board(dx, offset_tabs_x, clear_inner_x, dy, offset_tabs_y, clear_inner_y, handles) {
    row1_xc = (dx / 2) - (0.5 * wood_thickness);
    row1_yc = (dy / 2) - (0.5 * wood_thickness);
    difference() {
        cube([dx, dy, wood_thickness], center=true);
        for (rot=[180:180:180]) {
            rotate([0, 0, rot])
                translate([0, row1_yc, 0])
                edge_cutouts(dx, offset_tabs_x, clear_inner_x);
        }
        for (rot=[90:180:270]) {
            rotate([0, 0, rot])
                translate([0, row1_xc, 0])
                edge_cutouts(dy, offset_tabs_y, clear_inner_y);
        }
        if (handles) {
            translate([0, (dy / 2) - handle_r - handle_h_off, 0]) hull() {
                translate([-handle_c_sep / 2, 0, 0]) cylinder(r=handle_r, wood_thickness);
                translate([ handle_c_sep / 2, 0, 0]) cylinder(r=handle_r, wood_thickness);
            }
        }
    }
}

module bottom_outer_board(dx, offset_tabs_x, clear_inner_x, dy, offset_tabs_y, clear_inner_y) {
    row1_xc = (dx / 2) - (0.5 * wood_thickness);
    row1_yc = (dy / 2) - (0.5 * wood_thickness);
    difference() {
        cube([dx, dy, wood_thickness], center=true);
        for (rot=[0:180:180]) {
            rotate([0, 0, rot])
                translate([0, row1_yc, 0])
                edge_cutouts(dx, offset_tabs_x, clear_inner_x);
        }
        for (rot=[90:180:270]) {
            rotate([0, 0, rot])
                translate([0, row1_xc, 0])
                edge_cutouts(dy, offset_tabs_y, clear_inner_y);
        }
    }
}

module support(l) {
    difference() {
        cube([l, support_t, wood_thickness]);
        rotate(45) cube([support_t * 2, support_t * 2, wood_thickness]);
        translate([l, 0, 0]) rotate(45) cube([support_t * 2, support_t * 2, wood_thickness]);
    }
}

module box_parts() {
    projection(cut=true) translate([0, 0, 0])
        side_board(box_w, 1, 0, box_h, 1, 0, 0);
    projection(cut=true) translate([(box_w * 0.5) + (box_d * 0.5) + 10, 0, 0])
        side_board(box_d, 0, 0, box_h, 0, 1, 1);
    projection(cut=true) translate([(box_w * 1.0) + (box_d * 1.0) + 20, 0, 0])
        side_board(box_w, 1, 0, box_h, 1, 0, 0);
    projection(cut=true) translate([(box_w * 1.5) + (box_d * 1.5) + 30, 0, 0])
        side_board(box_d, 0, 0, box_h, 0, 1, 1);

    projection(cut=true) translate([0, -((box_h * 0.5) + (box_d * 0.5) + 10), 0])
        bottom_outer_board(box_w, 0, 1, box_d, 1, 1);
    *projection(cut=true) translate([(box_w * 0.5) + (box_d * 0.5) + 10, -((box_h * 0.5) + (box_w * 0.5) + 10), 0]) rotate(90)
        bottom_outer_board(box_w, 0, 1, box_d, 1, 1);

    projection(cut=true) translate([box_w * 0.5 + 10 + wood_thickness, -(box_h * 0.5 + 10 + support_t), 0])
        support(support_d);
    projection(cut=true) translate([box_w * 0.5 + 10 + wood_thickness, -(box_h * 0.5 + 10 + support_t * 2 + 10), 0])
        support(support_d);
    projection(cut=true)  translate([(box_w * 0.5) + (box_d * 1.0) + 20 + wood_thickness, -(box_h * 0.5 + 10 + support_t), 0])
        support(support_w);
    projection(cut=true)  translate([(box_w * 0.5) + (box_d * 1.0) + 20 + wood_thickness, -(box_h * 0.5 + 10 + support_t * 2 + 10), 0])
        support(support_w);

    projection(cut=true) translate([box_w * 0.5 + 10 + wood_thickness, -(box_h * 0.5 + 40 + support_t * 2), 0])
        cube([box_h - (2 * wood_thickness), wood_thickness, wood_thickness]);
    projection(cut=true) translate([box_w * 0.5 + 10 + wood_thickness, -(box_h * 0.5 + 50 + support_t * 2 + wood_thickness * 1), 0])
        cube([box_h - (2 * wood_thickness), wood_thickness, wood_thickness]);
    projection(cut=true) translate([box_w * 0.5 + 10 + wood_thickness, -(box_h * 0.5 + 60 + support_t * 2 + wood_thickness * 2), 0])
        cube([box_h - (2 * wood_thickness), wood_thickness, wood_thickness]);
    projection(cut=true) translate([box_w * 0.5 + 10 + wood_thickness, -(box_h * 0.5 + 70 + support_t * 2 + wood_thickness * 3), 0])
        cube([box_h - (2 * wood_thickness), wood_thickness, wood_thickness]);
}

box_parts();
