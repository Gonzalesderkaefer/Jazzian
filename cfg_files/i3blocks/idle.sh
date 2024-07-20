#!/bin/sh

# Determinig if swayidle can run

## declare "boolean"
swayidle_runnable=true;

## Test running swayidle
swayidle timeout 10 'echo HI!!' &
sleep 0.5s;


## if it can be killed it started succesfully so it is runnable
kill $! && swayidle_runnable=true || swayidle_runnable=false;




if [ "$swayidle_runnable" = true ]; then
    [ -n "$(pgrep swayidle)" ] && ( echo "󰾪 "; echo; echo \#ecc2fc ) || ( echo "󰅶 "; echo; echo \#f56464 )
fi
