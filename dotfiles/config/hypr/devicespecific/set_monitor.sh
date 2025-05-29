#!/bin/sh


wlr-randr --output DP-2 --off && (sleep 1 & hyprctl dispatch workspace 1)  && wlr-randr --output DP-2 --on --pos 2560,-250 --transform 90;
