#!/bin/sh

LOT="$(setxkbmap -query | awk '{ print $2 }'| sed -n '4p')" 

echo $LOT

if [[ $LOT == "intl"  ]]
then
  setxkbmap us
else 
  setxkbmap us intl altgr
fi
