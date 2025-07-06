#!/bin/sh


picom &

### Launching Tray elements
nm-applet &
### Load Xresources file
xrdb $HOME/.Xresources

## launch devicepecific stuff
if [ -f $HOME/.config/qtile/customized/customized.sh ]; then
    bash $HOME/.config/qtile/customized/customized.sh
fi
