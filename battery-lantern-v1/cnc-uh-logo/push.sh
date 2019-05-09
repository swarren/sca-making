#!/bin/sh
set -e
set -x
echo 'put lamp.nc "CNC Programs\swarren.nc"' | smbclient -U administrator -W WORKGROUP \\\\10.1.10.170\\shareddocs fcch
