#!/usr/bin/env sh
set -eu

# Forward port 24888 to 0.0.0.0:24800
ssh -f -N -L 24888:localhost:24800 someone@0.0.0.0
sleep 5
synergyc localhost:24888
