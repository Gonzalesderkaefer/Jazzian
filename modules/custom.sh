#! /bin/bash

# color variables
start_green="\033[0;32m"  
end_green="\033[0m "
start_red="\033[0;31m"
end_red="\033[0m"

# variables
custom=devicespecific;
customrc=devicerc;

echo -e "$start_green Going to create $custom files for custom conifiguration $end_green";

# for custom shell config

# zshrc or bashrc eqivalent
if ! [ -f $HOME/.$customrc ]; then
    touch $HOME/.$customrc;
fi


# zprofile or bash_profile equivalent
if ! [ -f $HOME/.$custom.sh ]; then
    touch $HOME/.$custom.sh;
    
    echo 'shell_tokill="$(echo $SHELL | grep -E -o "[^\/]*$")"' >> $HOME/.devicespecific.sh
    echo 'shells=$(ps | grep -E "tty1.*$shell_tokill" | awk '\''{print $1}'\'')' >> $HOME/.devicespecific.sh


    echo 'killshells()' >> $HOME/.devicespecific.sh
    echo '{' >> $HOME/.devicespecific.sh
    echo '   for shell in $shells; do' >> $HOME/.devicespecific.sh
    echo '       kill -9 $shell;' >> $HOME/.devicespecific.sh
    echo '   done' >> $HOME/.devicespecific.sh
    echo '}' >> $HOME/.devicespecific.sh

    echo '[ "$(tty)" = "/dev/tty1" ] && (startx; killshells)' >> $HOME/.devicespecific.sh
fi

# create xinitrc file regardless of display server choice
if ! [ -f $HOME/.xinitrc ]; then
    echo 'exec i3' >> $HOME/.xinitrc
fi

# configure which session needs to be started
case $1 in
    "wayland")
        sed -i "s/\&\& (.*; killshells)/\&\& ($2; killshells) /g" $HOME/.devicespecific.sh
        ;;
    *)
        sed -i "s/\&\& (.*; killshells)/\&\& (startx; killshells) /g" $HOME/.devicespecific.sh;
        sed -E -i "s/exec awesome|exec bspwm|exec i3/exec $2/g" $HOME/.xinitrc;
        ;;
esac



