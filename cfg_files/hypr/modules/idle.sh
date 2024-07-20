#!/bin/sh
swayidle -w \
  timeout 60 'hyprctl dispatch dpms off eDP-1' resume 'hyprctl dispatch dpms on eDP-1' \
  timeout 300 'swaylock -f -c 000000' \
  before-sleep 'swaylock -i Pictures/cube.png' &
