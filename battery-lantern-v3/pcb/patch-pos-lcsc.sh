#!/bin/sh

sed \
    -e 's/^\([^,]*\),[^,]*,[^,]*,/\1,/' \
    -e 's/^Ref,/Designator,/' \
    -e 's/,Pos\(.\)/,"Mid \1"/g' \
    -e 's/,Rot,/,Rotation,/g' \
    -e 's/,Side$/,Layer/g' \
    < flicker_lamp-all-pos.csv \
    > flicker_lamp-all-pos-lcsc.csv
