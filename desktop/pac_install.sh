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

############################## DEFINING FUNCTIONS ##############################

debian_install() {
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    
    sudo apt update ;
    sudo apt upgrade -y ;
    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;

    sudo apt install tmux zsh flatpak \
    git lf fonts-jetbrains-mono tlp \
    libglib2.0-bin nala  libnotify-bin 
    openssh-server nnn fzf -y ;

    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;
}


fedora_install() {
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    sudo dnf update -y ;

    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;
    sudo dnf install tmux zsh pinentry thunar polkit-gnome nnn neovim \
    flatpa mpv git  file-roller fzf jetbrains-mono-fonts -y ;
 
    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

}

arch_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    sudo pacman -Syu --noconfirm --needed;

    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;
    sudo pacman -S fzf tmux zsh nnn  \
    neovim lf \
    file-roller papirus-icon-theme gnome-themes-extra arc-gtk-theme \
    ttf-jetbrains-mono-nerd ttf-jetbrains-mono gcr bash-completion \
    zsh-completions gcc less wget man --noconfirm --needed; 
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

    



