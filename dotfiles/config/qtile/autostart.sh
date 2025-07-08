#!/bin/sh


picom &

### Launching Tray elements
nm-applet &
### Load Xresources file
xrdb $HOME/.Xresources

## launch devicepecific stuff
if [ -f $HOME/.config/qtile/devicespecific/devicespecific.sh ]; then
    bash $HOME/.config/qtile/devicespecific/devicespecific.sh
fi
