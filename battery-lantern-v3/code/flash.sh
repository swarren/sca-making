#!/bin/bash

cd "$(dirname "$0")"

set -e
set -x
sudo avrdude -p t13 -c usbtiny -v -U lfuse:w:0x7a:m -U hfuse:w:0xff:m -U flash:w:./Release/flicker_lamp.hex
