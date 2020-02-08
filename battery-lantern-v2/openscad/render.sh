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

# Lantern parts get LASER cut, so need SVG
shapes=()
shapes+=("all:0")
shapes+=("base-layer1:1")
shapes+=("base-layer2:2")
shapes+=("base-layer3:3")
shapes+=("top-layer1:4")
shapes+=("top-layer2:5")
shapes+=("top-layer3:6")
shapes+=("base-layer2-tabs-scored:7")

for array in 0 1; do
    if [ $array -eq 1 ]; then
      array_fn=-array
    else
      array_fn=
    fi
    for shape in "${shapes[@]}"; do
        IFS=: read name id <<< "${shape}"
        if [ $array -eq 1 ] && [ $id -eq 0 ]; then
            continue
        fi
        openscad \
            --render \
            -o ${name}${array_fn}.svg \
            -Dobject_selector=${id} \
            -Darray=${array} \
            lantern.scad
    done
done

openscad \
    --render \
    -o packed.svg \
    packed.scad

sed -E '/^<svg /s/ width="([0-9]+)" / width="\1mm" /' -i *.svg
sed -E '/^<svg /s/ height="([0-9]+)" / height="\1mm" /' -i *.svg
