#!/bin/bash

# create config file
config_file="$HOME/Jazzian/modules/devicespecific.conf"
if ! [ -f $config_file ]; then
    touch $config_file;
fi

# color variables
start_green="\033[0;32m"  
end_green="\033[0m "

# Ask for display server
echo -e "$start_green What display server would you like to use? $end_green";
echo; 
echo -e "$start_green [W]ayland $end_green";
echo -e "$start_green [X]org $end_green (Default)";

read -p "Your Choice: " server_choice;

case $server_choice in
    "X"* | "x"*)
        echo "Displayserver: xorg" > $config_file;
        ;;
    "W"* | "w"*)
        echo "Displayserver: wayland" > $config_file;
        ;;
    *)
        echo "Displayserver: xorg" > $config_file;
        ;;
esac


# Ask for window manager/compositor

echo -e "$start_green What window manager would you like to use? $end_green";
echo;

case $server_choice in
    "W"* | "w"*)
        echo -e "$start_green sway $end_green (Default)" 
        echo -e "$start_green river $end_green" 
        echo -e "$start_green Hyprland $end_green" 
        read -p "Your Choice: " wm_choice;
        case $wm_choice in 
            "S"* | "s"*)
                echo "Windowmanager: sway" >> $config_file;
                ;;
            "R"* | "r"*)
                echo "Windowmanager: river" >> $config_file;
                ;;
            "H"* | "h"*)
                echo "Windowmanager: Hyprland" >> $config_file;
                ;;
            *)
                echo "Windowmanager: sway" >> $config_file;
                ;;
        esac
        ;;
    *)
        echo -e "$start_green [i]3 $end_green (Default)" 
        echo -e "$start_green [b]spwm $end_green" 
        echo -e "$start_green [a]wesome $end_green" 
        read -p "Your Choice: " wm_choice;
        case $wm_choice in 
            "I"* | "i"*)
                echo "Windowmanager: i3" >> $config_file;
                ;;
            "B"* | "b"*)
                echo "Windowmanager: bspwm" >> $config_file;
                ;;
            "A"* | "a"*)
                echo "Windowmanager: awesome" >> $config_file;
                ;;
            *)
                echo "Windowmanager: i3" >> $config_file;
                ;;
        esac

        ;;
esac

# Ask user how to apply config files

echo -e "$start_green Would you like to [c]opy or [l]ink the config files? $end_green (Default: do nothing)";
echo;
read -p "Your Choice: " transfer;

case $transfer in
    "l"* | "L"*)
        echo "Transfer: link" >> $config_file;
        ;;
    "c"* | "C"*)
        echo "Transfer: copy" >> $config_file;
        ;;
    *)
        echo "Transfer: skip" >> $config_file;
        ;;
esac


echo -e "$start_green these are your options $end_green"
cat $config_file;
echo -e "$start_green Options saved. Will move on to apply changes. $end_green";
echo -e "$start_green Press ENTER to continue $end_green"
read continue;








