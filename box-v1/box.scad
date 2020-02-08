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
box_w = 116 + (4 * wood_thickness);
box_d = 75 + (4 * wood_thickness);
box_h = 68 + (4 * wood_thickness);
tab_unit = 4;

epsilon = 0.01;
half_epsilon = epsilon / 2;

function is_odd(val) = abs(val) % 2;
function floor_odd(val) = (floor(val) % 2) ? floor(val) : (floor(val) - 1);
function tabbed_width(dx) = dx - (4 * wood_thickness);
function tab_chunk_count(dx) = floor_odd(tabbed_width(dx) / (tab_unit * 3));

module inner_edge_cutouts(dx, offset_tabs, clear_inner) {
    tcc = tab_chunk_count(dx);
    tcc_per_side = (tcc - 1) / 2;

    clear_width_outer = ((dx - (tcc * 3 * tab_unit)) / 2) + epsilon;
    xlate_outer = (dx / 2) - (clear_width_outer / 2);
    clear_width_inner = ((dx - (tcc * 3 * tab_unit)) / 2) + (offset_tabs ? 0 : epsilon);
    xlate_inner = (dx / 2) - (clear_width_inner / 2);

    translate([-(xlate_outer + half_epsilon), wood_thickness + half_epsilon, 0])
        cube([clear_width_outer + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
    if (clear_inner)
        translate([-xlate_inner - half_epsilon, half_epsilon, 0])
            cube([clear_width_inner + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
    for (xp = [-tcc_per_side:1:tcc_per_side]) {
        translate([xp * 3 * tab_unit, 0, 0]) {
            if (is_odd(xp) == offset_tabs) {
                translate([0, (wood_thickness * 0.5) + half_epsilon, 0])
                    cube([tab_unit * 3, (wood_thickness * 2) + epsilon, wood_thickness + epsilon], center=true);
            }
            else {
                translate([-(tab_unit + half_epsilon), wood_thickness + half_epsilon, 0])
                    cube([tab_unit + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
                translate([tab_unit + half_epsilon, wood_thickness + half_epsilon, 0])
                    cube([tab_unit + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
            }
        }
    }
    if (clear_inner)
        translate([xlate_inner + half_epsilon, half_epsilon, 0])
            cube([clear_width_inner + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
    translate([xlate_outer + half_epsilon, wood_thickness + half_epsilon, 0])
        cube([clear_width_outer + epsilon, wood_thickness + epsilon, wood_thickness + epsilon], center=true);
}

module inner_board(dx, offset_tabs_x, clear_inner_x, dy, offset_tabs_y, clear_inner_y) {
    row1_xc = (dx / 2) - (1.5 * wood_thickness);
    row1_yc = (dy / 2) - (1.5 * wood_thickness);
    difference() {
        cube([dx, dy, wood_thickness], center=true);
        for (rot=[0:180:180]) {
            rotate([0, 0, rot])
                translate([0, row1_yc, 0])
                inner_edge_cutouts(dx, offset_tabs_x, clear_inner_x);
        }
        for (rot=[90:180:270]) {
            rotate([0, 0, rot])
                translate([0, row1_xc, 0])
                inner_edge_cutouts(dy, offset_tabs_y, clear_inner_y);
        }
    }
}

module outer_edge_cutouts(dx, offset_tabs, clear_outer, do_outer_epsilon) {
    tcc = tab_chunk_count(dx);
    tcc_per_side = (tcc - 1) / 2;

    clear_width_outer = ((dx - (tcc * 3 * tab_unit)) / 2) + (offset_tabs ? 0 : epsilon);
    xlate_outer = (dx / 2) - (clear_width_outer / 2);

    y_eps = do_outer_epsilon ? epsilon : 0;
    y_half_eps = do_outer_epsilon ? half_epsilon : 0;

    if (clear_outer)
        translate([-xlate_outer - half_epsilon, wood_thickness + y_half_eps, 0])
            cube([clear_width_outer + epsilon, wood_thickness + y_eps, wood_thickness + epsilon], center=true);
    for (xp = [-tcc_per_side:1:tcc_per_side]) {
        translate([xp * 3 * tab_unit, 0, 0]) {
            if (is_odd(xp) == offset_tabs) {
                cube([tab_unit, wood_thickness, wood_thickness + epsilon], center=true);
            }
            else {
                translate([0, wood_thickness + y_half_eps, 0])
                    cube([tab_unit * 3, wood_thickness + y_eps, wood_thickness + epsilon], center=true);
            }
        }
    }
    if (clear_outer)
        translate([xlate_outer + half_epsilon, wood_thickness + y_half_eps, 0])
            cube([clear_width_outer + epsilon, wood_thickness + y_eps, wood_thickness + epsilon], center=true);
}

module outer_board_stand(dx, wide_stand, dy) {
    r = dy - (1.5 * wood_thickness);
    ox = (dx / 2) - (3 * wood_thickness) - r;
    oy = dy / 2;

    difference() {
        cube([dx - ((1 - wide_stand) * 2 * wood_thickness), dy, wood_thickness], center=true);
        hull() {
            translate([-ox, oy, 0])
                cylinder(r=r, h=wood_thickness + epsilon, center=true);
            translate([ox, oy, 0])
                cylinder(r=r, h=wood_thickness + epsilon, center=true);
        }
    };
}

module outer_board(dx, offset_tabs_x, clear_outer_x, dy, offset_tabs_y, clear_outer_y,
        stand_side, stand_height, wide_stand) {
    row1_xc = (dx / 2) - (1.5 * wood_thickness);
    row1_yc = (dy / 2) - (1.5 * wood_thickness);
    no_outer_epsilon_rot = (stand_side == -1) ? -1 : (stand_side * 90);
    difference() {
        union() {
            cube([dx, dy, wood_thickness], center=true);
            if (stand_side != -1) {
                stand_dxy = ((stand_side % 2) == 1) ? dx : dy;
                stand_dyx = ((stand_side % 2) == 1) ? dy : dx;
                rotate([0, 0, stand_side * 90])
                    translate([0, (stand_dxy + stand_height) / 2, 0])
                    outer_board_stand(stand_dyx, wide_stand, stand_height + epsilon);
            }

        }
        for (rot=[0:180:180]) {
            rotate([0, 0, rot])
                translate([0, row1_yc, 0])
                outer_edge_cutouts(dx, offset_tabs_x, clear_outer_x, rot != no_outer_epsilon_rot);
        }
        for (rot=[90:180:270]) {
            rotate([0, 0, rot])
                translate([0, row1_xc, 0])
                outer_edge_cutouts(dy, offset_tabs_y, clear_outer_y, rot != no_outer_epsilon_rot);
        }
    }
}

module top_rim(w, h) {
    ow = w - (4 * wood_thickness);
    oh = h - (4 * wood_thickness);
    difference() {
        cube([ow, oh, wood_thickness], center=true);
        cube([ow - 6, oh - 6, wood_thickness], center=true);
    }
}

if (0) {
    inner_explode_offset = 2 * wood_thickness;
    inner_half_center_w = (box_w / 2) - (1.5 * wood_thickness) + inner_explode_offset;
    inner_half_center_d = (box_d / 2) - (1.5 * wood_thickness) + inner_explode_offset;
    inner_half_center_h = (box_h / 2) - (1.5 * wood_thickness) + inner_explode_offset;
    color([1, 0.5, 0.5]) translate([0, 0, inner_half_center_h]) rotate([0, 0, 0]) inner_board(box_w, 1, 0, box_d, 1, 0);
    color([1, 0.5, 0.5]) translate([0, 0, -inner_half_center_h]) rotate([0, 0, 0]) inner_board(box_w, 1, 0, box_d, 1, 0);
    color([0.5, 1, 0.5]) translate([0, inner_half_center_d, 0]) rotate([90, 0, 0]) inner_board(box_w, 0, 1, box_h, 0, 1);
    color([0.5, 1, 0.5]) translate([0, -inner_half_center_d, 0]) rotate([90, 0, 0]) inner_board(box_w, 0, 1, box_h, 0, 1);
    color([0.5, 0.5, 1]) translate([inner_half_center_w, 0, 0]) rotate([0, 90, 0]) inner_board(box_h, 1, 0, box_d, 0, 1);
    color([0.5, 0.5, 1]) translate([-inner_half_center_w, 0, 0]) rotate([0, 90, 0]) inner_board(box_h, 1, 0, box_d, 0, 1);
}

if (0) {
    outer_explode_offset = 2 * wood_thickness;
    outer_half_center_w = (box_w / 2) - (0.5 * wood_thickness) + outer_explode_offset;
    outer_half_center_d = (box_d / 2) - (0.5 * wood_thickness) + outer_explode_offset;
    outer_half_center_h = (box_h / 2) - (0.5 * wood_thickness) + outer_explode_offset;
    color([1, 0.5, 0.5]) translate([0, 0, outer_half_center_h]) rotate([0, 0, 0]) outer_board(box_w, 1, 0, box_d, 1, 0, -1, 0, 0);
    color([1, 0.5, 0.5]) translate([0, 0, -outer_half_center_h]) rotate([0, 0, 0]) outer_board(box_w, 1, 0, box_d, 1, 0, -1, 0, 0);
    color([0.5, 1, 0.5]) translate([0, outer_half_center_d, 0]) rotate([90, 0, 0]) outer_board(box_w, 0, 1, box_h, 0, 1, 2, 4 * wood_thickness, 1);
    color([0.5, 1, 0.5]) translate([0, -outer_half_center_d, 0]) rotate([90, 0, 0]) outer_board(box_w, 0, 1, box_h, 0, 1, 2, 4 * wood_thickness, 1);
    color([0.5, 0.5, 1]) translate([outer_half_center_w, 0, 0]) rotate([0, 90, 0]) outer_board(box_h, 1, 0, box_d, 0, 1, 3, 4 * wood_thickness, 0);
    color([0.5, 0.5, 1]) translate([-outer_half_center_w, 0, 0]) rotate([0, 90, 0]) outer_board(box_h, 1, 0, box_d, 0, 1, 3, 4 * wood_thickness, 0);
}

if (1) {
    projection(cut=true) translate([box_w * 0,   0, 0]) inner_board(box_w, 1, 0, box_d, 1, 0);
    projection(cut=true) translate([box_w * 1.5, 0, 0]) inner_board(box_w, 1, 0, box_d, 1, 0);
    projection(cut=true) translate([box_w * 3,   0, 0]) inner_board(box_w, 0, 1, box_h, 0, 1);
    projection(cut=true) translate([box_w * 4.5, 0, 0]) inner_board(box_w, 0, 1, box_h, 0, 1);
    projection(cut=true) translate([box_w * 6,   0, 0]) inner_board(box_h, 1, 0, box_d, 0, 1);
    projection(cut=true) translate([box_w * 7.3, 0, 0]) inner_board(box_h, 1, 0, box_d, 0, 1);

    projection(cut=true) translate([box_w * 0,   box_d * 1.75, 0]) outer_board(box_w, 1, 0, box_d, 1, 0, -1, 0, 0);
    projection(cut=true) translate([box_w * 1.5, box_d * 1.75, 0]) outer_board(box_w, 1, 0, box_d, 1, 0, -1, 0, 0);
    projection(cut=true) translate([box_w * 3,   box_d * 1.75, 0]) outer_board(box_w, 0, 1, box_h, 0, 1, 2, 4 * wood_thickness, 1);
    projection(cut=true) translate([box_w * 4.5, box_d * 1.75, 0]) outer_board(box_w, 0, 1, box_h, 0, 1, 2, 4 * wood_thickness, 1);
    projection(cut=true) translate([box_w * 6,   box_d * 1.75, 0]) outer_board(box_h, 1, 0, box_d, 0, 1, 3, 4 * wood_thickness, 0);
    projection(cut=true) translate([box_w * 7.3, box_d * 1.75, 0]) outer_board(box_h, 1, 0, box_d, 0, 1, 3, 4 * wood_thickness, 0);

    projection(cut=true) translate([box_w * 0,   box_d * 3.5, 0]) top_rim(box_w, box_d);
}
