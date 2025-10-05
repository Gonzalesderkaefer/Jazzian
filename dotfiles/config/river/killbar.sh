#!/bin/sh

kill $(pgrep waybar) || waybar -c $HOME/.config/waybar/config_river &
