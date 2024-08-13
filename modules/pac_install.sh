#!/bin/bash

# color variables
start_green="\033[0;32m"  
end_green="\033[0m "
start_red="\033[0;31m"
end_red="\033[0m"

# logfile variable
log_file=$HOME/Jazzian/devicespecific.log

############################## DEFINING FUNCTIONS ##############################

debian_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    
    sudo apt update >> $log_file;
    sudo apt upgrade -y >> $log_file;
    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;

    sudo apt install tmux zsh evince flatpak network-manager network-manager-gnome \ 
    thunar file-roller network-manager-openconnect-gnome eom network-manager-openconnect \ 
    git lf fonts-jetbrains-mono firefox-esr tlp alacritty pipewire pipewire-alsa \ 
    pipewire-pulse libglib2.0-bin nala mpv papirus-icon-theme gnome-themes-extra \ 
    arc-theme libnotify-bin acpi-support acpid acpi linux-cpupower cpufrequtils \ 
    openssh-server nnn fzf zathura -y >> $log_file;

    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

    case $1 in 
        "wayland")
            sudo apt install grim swaylock wofi xwayland wlr-randr wl-clipboard swayidle \ 
            mako-notifier -y >> $log_file;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in
                "river")
                    sudo apt install sway i3blocks -y >> $log_file;
                    ;;
                "Hyprland")
                    sudo apt install sway i3blocks -y >> $log_file;
                    ;;
                *)
                    sudo apt install sway i3blocks -y >> $log_file;
                    ;;
            esac
            ;;
        *)
            sudo apt install lxappearance xrandr arandr rofi xclip i3lock picom dunst \ 
            xinput xorg xwallpaper -y >> $log_file;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in
                "awesome")
                    sudo apt install i3 i3blocks -y >> $log_file;
                    ;;
                "bspwm")
                    sudo apt install awesome -y >> $log_file;
                    ;;
                *)
                    sudo apt install bspwm sxhkd polybar -y >> $log_file;
                    ;;
            esac
            ;;
    esac

    



    
}


# Checking if script is run with arguments
if [ -z $1 ] || [ -z $2 ]; then
    echo -e "$start_red This script expects at least two arguments $end_red";
    exit 1;
fi


    



