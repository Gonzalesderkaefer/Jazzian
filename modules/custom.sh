#! /bin/bash


####### SPEC #######
# $1: Displayserver
# $2: Windowmanager 
# $3: Distro 


# color variables
start_green="\033[0;32m"  
end_green="\033[0m "
start_red="\033[0;31m"
end_red="\033[0m"

# variables
custom=devicespecific;
custom_theme=devicespecific_theme;
customrc=devicerc;

## checking if is run with two arguements
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
    echo -e "$start_red This script expects at least three arguments $end_red";
    exit 1;
fi


echo -e "$start_green Going to create $custom files for custom conifiguration $end_green";

# for custom shell config

# zshrc or bashrc eqivalent
if ! [ -f $HOME/.$customrc ]; then
    touch $HOME/.$customrc;
fi


# zprofile or bash_profile equivalent
if ! [ -f $HOME/.$custom.sh ]; then
    touch $HOME/.$custom.sh;
    
    echo 'killshells()' >> $HOME/.$custom.sh
    echo '{' >> $HOME/.devicespecific.sh
    echo '    pkill -KILL -u $USER -t tty1' >> $HOME/.$custom.sh
    echo '}' >> $HOME/.$custom.sh

    echo 'export WM=i3' >> $HOME/.$custom.sh
    echo '[ "$(tty)" = "/dev/tty1" ] && (startx; killshells)' >> $HOME/.$custom.sh
fi

# create xinitrc file regardless of display server choice
if ! [ -f $HOME/.xinitrc ]; then
    echo 'exec i3' >> $HOME/.xinitrc
fi

# configure which session needs to be started
case $1 in
    "wayland")
        sed  -i "s/export WM=.*$/export WM=$2/g" $HOME/.$custom.sh
        sed -i "s/\&\& (.*; killshells)/\&\& ($2; killshells) /g" $HOME/.$custom.sh
        ;;
    *)
        sed  -i "s/export WM=.*$/export WM=$2/g" $HOME/.$custom.sh
        sed -i "s/\&\& (.*; killshells)/\&\& (startx; killshells) /g" $HOME/.$custom.sh;
        sed -E -i "s/exec awesome|exec bspwm|exec i3/exec $2/g" $HOME/.xinitrc;
        ;;
esac

# configure Menu
case $3 in
    "debian")
        echo '#!/usr/bin/sh' > $HOME/.local/bin/mdmenu
        echo 'if [ $XDG_SESSION_TYPE = "wayland" ]; then ' >> $HOME/.local/bin/mdmenu
        echo '    wofi_dmenu;' >> $HOME/.local/bin/mdmenu
        echo 'else' >> $HOME/.local/bin/mdmenu
        echo '    rofi_dmenu;' >> $HOME/.local/bin/mdmenu
        echo 'fi' >> $HOME/.local/bin/mdmenu
        chmod +x $HOME/.local/bin/mdmenu

        echo '#!/usr/bin/sh' > $HOME/.local/bin/mdrun
        echo 'if [ $XDG_SESSION_TYPE = "wayland" ]; then ' >> $HOME/.local/bin/mdrun
        echo '    wofi_app;' >> $HOME/.local/bin/mdrun
        echo 'else' >> $HOME/.local/bin/mdrun
        echo '    rofi_app;' >> $HOME/.local/bin/mdrun
        echo 'fi' >> $HOME/.local/bin/mdrun
        chmod +x $HOME/.local/bin/mdrun
        ;;
    *)
        echo '#!/usr/bin/sh' > $HOME/.local/bin/mdmenu
        echo 'rofi_dmenu;' >> $HOME/.local/bin/mdmenu
        chmod +x $HOME/.local/bin/mdmenu

        echo '#!/usr/bin/sh' > $HOME/.local/bin/mdrun
        echo 'rofi_app;' >> $HOME/.local/bin/mdrun
        chmod +x $HOME/.local/bin/mdrun
        ;;
esac


# Creating files for i3
mkdir -p $HOME/.config/i3/$custom
[ -f $HOME/.config/i3/$custom/$custom ] || touch $HOME/.config/i3/$custom/$custom;

# Creating files for awesomewm
[ -d $HOME/.config/awesome/$custom ] || mkdir $HOME/.config/awesome/$custom;
[ -f $HOME/.config/awesome/$custom/$custom_theme.lua ] || touch $HOME/.config/awesome/$custom/$custom_theme.lua;
[ -f $HOME/.config/awesome/$custom/$custom.lua ] || touch $HOME/.config/awesome/$custom/$custom.lua;

# Creating files for bspwm
mkdir -p $HOME/.config/bspwm/$custom/;
[ -f $HOME/.config/bspwm/$custom/$custom ] || ( touch $HOME/.config/bspwm/$custom/$custom;
echo '#!/bin/sh' >> $HOME/.config/bspwm/$custom/$custom );

# Creating files for Hyprland
mkdir -p $HOME/.config/hypr/$custom/;
[ -f $HOME/.config/hypr/$custom/$custom ] || touch $HOME/.config/hypr/$custom/$custom;


# Creating files for sway 
mkdir -p $HOME/.config/sway/$custom/;
[ -f $HOME/.config/sway/$custom/$custom ] || touch $HOME/.config/sway/$custom/$custom;

# Creating files for river 
mkdir -p $HOME/.config/river/$custom/;
[ -f $HOME/.config/river/$custom/$custom ] || touch $HOME/.config/river/$custom/$custom;


# Creating startup script for x11
if ! [ -f $HOME/.local/bin/x11startup ]; then
    touch $HOME/.local/bin/x11startup;
    chmod +x $HOME/.local/bin/x11startup;
fi


# Setting theme to Arc-Dark
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'

# Setting gtk-font to Jetbrains Mono
gsettings set org.gnome.desktop.interface font-name 'Jetbrains Mono'

# Setting icon theme to papirus
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# nvim user-specifc configuration
if [ -f $HOME/.config/nvim/lua ]; then
    touch $HOME/.config/nvim/lua/devicespecific.lua;
fi


if [ -f $HOME/.config/nvim/lua ]; then
    touch $HOME/.config/nvim/lua/devicespecific.lua;
fi

if [ -f $HOME/.config/vim/devicespecific ]; then
    touch $HOME/.config/vim/devicespecific;
fi


# write myterm file
if ! [ -f $HOME/.local/bin/myterm ]; then
    printf '
    #!/bin/dash

    case $XDG_SESSION_TYPE in
        "wayland")
            alacritty -o font.size=12
            ;;
        *)
            alacritty -o font.size=12
            ;;
    esac
    ' > $HOME/.local/bin/myterm
fi

chmod +x $HOME/.local/bin/myterm

# switch shell to zsh
echo -e "${start_green}Changing shell to zsh..${end_green}"
chsh -s /usr/bin/zsh

