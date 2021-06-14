/*
 * Copyright 2021 Stephen Warren <swarren@wwwdotorg.org>
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

include <body.scad>;
include <constants.scad>;
include <core.scad>;

translate([0, 0, 0])
    core_layer_1();
translate([core_r * 2.5 * 1, 0, 0])
    core_layer_2();
translate([core_r * 2.5 * 2, 0, 0])
    core_layer_2_engrave();
translate([core_r * 2.5 * 3, 0, 0])
    core_layer_3();
translate([core_r * 2.5 * 4, 0, 0])
    core_layer_led_bottom();
translate([core_r * 2.5 * 5, 0, 0])
    core_layer_led_top();

translate([0, core_r * 2.5, 0])
    square(size=[core_rod_height, core_rod_thick]);

translate([0, -body_r * 2, 0])
    body_layer_1();
translate([body_r * 2.5 * 1, -body_r * 2, 0])
    body_layer_2();
translate([body_r * 2.5 * 2, -body_r * 2, 0])
    body_layer_3();
translate([body_r * 2.5 * 3, -body_r * 2, 0])
    body_layer_4();
translate([body_r * 2.5 * 4, -body_r * 2, 0])
    body_layer_5();
translate([body_r * 2.5 * 5, -body_r * 2, 0])
    body_layer_6();


