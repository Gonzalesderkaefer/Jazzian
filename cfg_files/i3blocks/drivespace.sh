#!/bin/sh
#

ROOT_SPACE="$(df -H | grep -E "/$" | awk '{print $3}')"
HOME_SPACE="$(df -H | grep -E "/home$" | awk '{print $3}')"

[ -n "$HOME_SPACE" ] &&  echo "$ROOT_SPACE   $HOME_SPACE   " || echo "$ROOT_SPACE   "

