#!/bin/sh

# testrunning swayidle to get ist exit code 
swayidle;


# If the exit code is zero swaymsg just exited without any error
# On X11 it would not have code 0

if [ $? = 0 ]; then
    [ -n "$(pgrep swayidle)" ] && ( echo "󰾪 "; echo; echo \#ecc2fc ) || ( echo "󰅶 "; echo; echo \#f56464 )
fi
#ps -o command= $(pgrep swayidle)
