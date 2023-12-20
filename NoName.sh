#!/bin/sh

LOT="$(cat ~/KeyboardLayouts | rofi -dmenu)" 


setxkbmap $LOT  
