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

$fn = 50;

module portcullis(size) {
  unit = size / 9;

  intersection() {
    union() {
      for (xp = [-2:2]) {
        translate([xp * unit * 2, 0, size / 9])
          cylinder(h=size * (8 / 9), r=(unit * 0.5), r2=(unit * 0.5));
        translate([xp * unit * 2, 0, -1])
          cylinder(h=(unit * 1.5), r=0, r2=(unit * 0.75));
      }
      for (yp = [1:4]) {
        translate([-(unit * 4), 0, (yp + 0.5) * (unit * 2)])
          rotate([0, 90, 0])
          cylinder(h=(unit * 8), r=(unit * 0.5), r2=(unit * 0.5));
      }
      translate([-unit * 4, 0, unit * 9], center=true)
        sphere(r=unit * 0.5);
      translate([unit * 4, 0, unit * 9], center=true)
        sphere(r=unit * 0.5);
    }
    translate([-size * 0.55, -size / 10, 0])
      cube([size * 1.1, size / 10, size * 1.1]);
  }
}

module backed_portcullis(size, back_thick) {
  union() {
    translate([0, back_thick, 0])
      rotate([90, 0, 0])
      linear_extrude(height=back_thick)
      projection()
      rotate([-90, 0, 0])
      portcullis(size);
    portcullis(size);
  }
}

module cookie_raised() {
  color([1, 1, 0])
    translate([0, 1.01, 3.5])
    rotate([90, 0, 0])
    cylinder(r=8, $fn=360);
  color([1, 0, 0])
    portcullis(9);
}

module cookie_indent() {
  color([1, 1, 0])
    difference() {
      translate([0, 1.01, 4])
        rotate([90, 0, 0])
        cylinder(r=8, $fn=360);
     rotate([0, 0, 180])
        portcullis(9);
    }
  color([1, 0, 0])
    rotate([0, 0, 180])
    portcullis(9);
}

/*
translate([-10, 0, 0]) cookie_indent();
translate([10, 0, 0]) cookie_raised();
*/

backed_portcullis(50, 3.5);

/*
scale([1, 2.25, 1])
  portcullis(50, 3.5);
*/
