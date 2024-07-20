#!/bin/sh
#
#i = 0;
#while [ true ]
#do
#    i=$((i+1));
#    echo $((i % 2));
#
#done



#arrayIndex=0;
#declare layouts;
#layouts[0] = "US"
#layouts[1] = "US-Intl"

#echo "${DASH_SOURCE[0]}"
thisDir="$HOME/.config/waybar/modules"
[ "$(cat $thisDir/layout)" = "US" ] && echo "US-Intl" > $thisDir/layout || echo "US" > $thisDir/layout 
