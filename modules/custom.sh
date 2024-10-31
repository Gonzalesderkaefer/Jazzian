#! /bin/bash


####### SPEC #######
# $1: Displayserver
# $2: Windowmanager 


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
if [ -z $1 ] || [ -z $2 ]; then
    echo -e "$start_red This script expects at least two arguments $end_red";
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
    
    echo 'shell_tokill="$(echo $SHELL | grep -E -o "[^\/]*$")"' >> $HOME/.$custom.sh
    echo 'shells=$(ps | grep -E "tty1.*$shell_tokill" | awk '\''{print $1}'\'')' >> $HOME/.$custom.sh


    echo 'killshells()' >> $HOME/.$custom.sh
    echo '{' >> $HOME/.devicespecific.sh
    echo '   for shell in $shells; do' >> $HOME/.$custom.sh
    echo '       kill -9 $shell;' >> $HOME/.$custom.sh
    echo '   done' >> $HOME/.$custom.sh
    echo '}' >> $HOME/.$custom.sh

    echo '[ "$(tty)" = "/dev/tty1" ] && (startx; killshells)' >> $HOME/.$custom.sh
    echo 'export WM=i3' >> $HOME/.$custom.sh
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



