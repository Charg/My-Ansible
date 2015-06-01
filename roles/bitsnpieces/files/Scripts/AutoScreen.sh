#!/bin/bash

laptop=$(xrandr | grep LVDS1 | awk '{print $2}')
screen1=$(xrandr | grep -m1 VGA1 | awk '{print $2}')

echo $laptop
echo $screen1

# Both EXT displays are NOT connected
if [ "$screen1" = "disconnected" ]
then 
	echo "Screen is disconnected"
	xrandr --output LVDS1 --mode 1366x768
fi

# Both EXT displays ARE connected
if [ "$screen1" = "connected" ]
then
	echo "Both Screens are Connected"
	xrandr --output VGA1 --mode 1280x1024 --right-of LVDS1
fi
