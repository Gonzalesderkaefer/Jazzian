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


[ "$(cat layout)" = "US" ] && echo "US-Intl" > layout || echo "US" > layout 
