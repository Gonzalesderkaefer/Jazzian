#!/bin/bash

####### SPEC #######
# $1: Distro
# $2: Displayserver
# $3: Windowmanager 



# color variables
start_green="\033[0;32m"  
end_green="\033[0m "
start_red="\033[0;31m"
end_red="\033[0m"

# logfile variable
log_file=$HOME/Jazzian/devicespecific.log

# predfined packages
if [ -f $HOME/Jazzian/modules/packages.sh ]; then
    source $HOME/Jazzian/modules/packages.sh; 
else
    exit 1;
fi


############################## DEFINING FUNCTIONS ##############################

debian_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    
    sudo apt update ;
    sudo apt upgrade -y ;
    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;

    case $1 in 
        "wayland")
            case $2 in
                "river")
                    sudo apt install $debian_base $debian_wayland $debian_river -y ;
                    ;;
                "Hyprland")
                    sudo apt install $debian_base $debian_wayland $debian_hypr -y ;
                    ;;
                *)
                    sudo apt install $debian_base $debian_wayland $debian_sway -y ;
                    ;;
            esac
            ;;
        *)
            case $2 in
                "awesome")
                    sudo apt install $debian_base $debian_xorg $debian_awesome -y ;
                    ;;
                "bspwm")
                    sudo apt install $debian_base $debian_xorg $debian_bspwm -y ;
                    ;;
                *)
                    sudo apt install $debian_base $debian_xorg $debian_i3 -y ;
                    ;;
            esac
            ;;
    esac
}


fedora_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    sudo dnf update -y ;

    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;
    case $1 in
        "wayland")
            case $2 in 
                "H"* | "h"*)
                    sudo dnf install $fedora_base $fedora_wayland $fedora_hypr -y ;
                    ;;
                "R"* | "r"*)
                    sudo dnf install $fedora_base $fedora_wayland $fedora_river -y ;
                    ;;
                *)
                    sudo dnf install $fedora_base $fedora_wayland $fedora_sway -y ;
                    ;;
            esac
            ;;
        *)
            case $2 in 
                "A"* | "a"*)
                    sudo dnf install $fedora_base $fedora_xorg $fedora_awesome -y ;
                    ;;
                "B"* | "b"*)
                    sudo dnf install $fedora_base $fedora_xorg $fedora_bspwm -y ;
                    ;;
                *)
                    sudo dnf install $fedora_base $fedora_xorg $fedora_i3 -y ;
                    ;;
            esac
            ;;
    esac
}

arch_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    sudo pacman -Syu --noconfirm --needed;

    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;
    case $1 in
        "wayland")
            case $2 in 
                "H"* | "h"*)
                    sudo pacman -S $arch_base $arch_wayland $arch_hypr --noconfirm --needed;
                    ;;
                "R"* | "r"*)
                    sudo pacman -S $arch_base $arch_wayland $arch_river --noconfirm --needed;
                    ;;
                *)
                    sudo pacman -S $arch_base $arch_wayland $arch_sway --noconfirm --needed;
                    ;;
            esac
            ;;
        *)
            case $2 in 
                "A"* | "a"*)
                    sudo pacman -S $arch_base $arch_xorg $arch_awesome --noconfirm --needed;
                    ;;
                "B"* | "b"*)
                    sudo pacman -S $arch_base $arch_xorg $arch_bspwm --noconfirm --needed;
                    ;;
                *)
                    sudo pacman -S $arch_base $arch_xorg $arch_i3 --noconfirm --needed;
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

case $1 in 
    "debian")
        debian_install $2 $3;
        ;;
    "fedora")
        fedora_install $2 $3;
        ;;
    "archlinux")
        arch_install $2 $3;
        ;;
    *)
        echo -e "$start_red The distro this system is running on is not supported by this script.$end_red"
        echo -e "$start_red You can inspect the script in $HOME/Jazzian/modules/pac_install and try to $end_red"
        echo -e "$start_red install the packages manually or you can skip. $end_red"
esac

    



