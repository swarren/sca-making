#!/bin/bash

# Copyright 2019 Stephen Warren <swarren@wwwdotorg.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

# LED mount gets 3D-printed, so needs STL
openscad \
    --render \
    -o led-mount.stl \
    led-mount.scad

# Lantern parts get LASER cut, so need SVG
shapes=()
shapes+=("base-layer1:1")
shapes+=("base-layer2:2")
shapes+=("base-layer3:3")
shapes+=("top:4")
for shape in "${shapes[@]}"; do
    IFS=: read name id <<< "${shape}"
    openscad \
        --render \
        -o ${name}.svg \
        -Dobject_selector=${id} \
        lantern.scad
done

sed -E '/^<svg /s/ width="([0-9]+)" / width="\1mm" /' -i *.svg
sed -E '/^<svg /s/ height="([0-9]+)" / height="\1mm" /' -i *.svg
