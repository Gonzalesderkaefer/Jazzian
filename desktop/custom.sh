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
[ -f $HOME/.config/awesome/$custom.lua ] || touch $HOME/.config/awesome/$custom.lua;
[ -f $HOME/.config/awesome/$custom_theme.lua ] || touch $HOME/.config/awesome/$custom_theme.lua;

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


# Setting theme to Arc-Dark
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'

# Setting gtk-font to Jetbrains Mono
gsettings set org.gnome.desktop.interface font-name 'Jetbrains Mono'


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



## Write .Xresources file
echo 'URxvt*letterSpace: 0' >> $HOME/.Xresources
echo 'URxvt*font: xft:JetBrainsMono Nerd Font Mono:style=Regular:pixelsize=15:antialias=true:hinting=true' >> $HOME/.Xresources
echo 'URxvt.background: #303446' >> $HOME/.Xresources
echo 'URxvt.foreground: #c6d0f5' >> $HOME/.Xresources
echo 'URxvt.scrollBar: false' >> $HOME/.Xresources
echo 'URxvt.geometry: 400x400' >> $HOME/.Xresources

echo '! Colors'
echo 'urxvt*color0:   #51577d' >> $HOME/.Xresources
echo 'urxvt*color1:   #e78284' >> $HOME/.Xresources
echo 'urxvt*color2:   #a6d189' >> $HOME/.Xresources
echo 'urxvt*color3:   #e5c890' >> $HOME/.Xresources
echo 'urxvt*color4:   #8caaee' >> $HOME/.Xresources
echo 'urxvt*color5:   #f4b8e4' >> $HOME/.Xresources
echo 'urxvt*color6:   #81c8be' >> $HOME/.Xresources
echo 'urxvt*color7:   #303446' >> $HOME/.Xresources
echo 'urxvt*color8:#626881' >> $HOME/.Xresources
echo 'urxvt*color9:#e78284' >> $HOME/.Xresources
echo 'urxvt*color10:#a6d189' >> $HOME/.Xresources
echo 'urxvt*color11:#e5c890' >> $HOME/.Xresources
echo 'urxvt*color12:#8caaee' >> $HOME/.Xresources
echo 'urxvt*color13:#f4b8e4' >> $HOME/.Xresources
echo 'urxvt*color14:#81c8be' >> $HOME/.Xresources
echo 'urxvt*color15:#a5adce' >> $HOME/.Xresources
echo '! Rebinding copy and paste'
echo 'URxvt.keysym.Shift-Control-V: eval:paste_clipboard' >> $HOME/.Xresources
echo 'URxvt.keysym.Shift-Control-C: eval:selection_to_clipboard' >> $HOME/.Xresources



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



