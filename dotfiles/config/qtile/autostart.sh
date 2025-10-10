#!/bin/sh


picom &

### Launching Tray elements
nm-applet &

nitrogen --restore

## launch devicepecific stuff
if [ -f $HOME/.config/qtile/customized/customized.sh ]; then
    bash $HOME/.config/qtile/customized/customized.sh
fi
