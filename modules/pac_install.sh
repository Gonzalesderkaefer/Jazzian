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


fedora_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    sudo dnf update -y >> $log_file;

    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;
    sudo dnf install tmux zsh pinentry thunar polkit-gnome nnn neovim alacritty \
    mpv firefox zathura zathura-pdf-poppler evince git pipewire pipewire-utils \
    file-roller pipewire-pulseaudio NetworkManager-openconnect-gnome \
    gsettings-desktop-schemas papirus-icon-theme NetworkManager-tui eom tlp libnotify \
    pipewire-alsa qalculate-gtk fzf jetbrains-mono-fonts papirus-icon-theme-dark \
    network-manager-applet -y >> $log_file; 
 
    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

    case $1 in
        "wayland")
            sudo dnf install grim swaybg swayidle swaylock waybar wofi wl-clipboard -y >> $log_file;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
                
            case $2 in 
                "S"* | "s"*)
                    sudo dnf install sway i3blocks -y >> $log_file;
                    ;;
                "H"* | "h"*)
                    sudo dnf install hyprland waybar -y >> $log_file;
                    ;;
                "R"* | "r"*)
                    sudo dnf install river waybar -y >> $log_file;
                    ;;
            esac
            ;;
        *)
            sudo dnf install xclip @base-x lxappearance nitrogen picom dunst xclip -y >> $log_file;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in 
                "I"* | "i"*)
                    sudo dnf install i3 i3blocks -y >> $log_file;
                    ;;
                "A"* | "a"*)
                    sudo dnf install awesome -y >> $log_file;
                    ;;
                "B"* | "b"*)
                    sudo dnf install bspwm polybar -y >> $log_file;
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
    sudo pacman -Syu --noconfirm >> $log_file;

    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;
    sudo pacman -S fzf tmux zsh nnn networkmanager thunar nm-connection-editor \
    neovim zathura-pdf-poppler zathura evince webkit2gtk-4.1 networkmanager-openconnect \
    firefox lf tlp alacritty pipewire mpv gsettings-desktop-schemas network-manager-applet \
    openconnect lxappearance file-roller papirus-icon-theme gnome-themes-extra arc-gtk-theme \
    ttf-jetbrains-mono-nerd gcr bash-completion zsh-completions gcc less wget pipewire-pulse \
    pipewire-alsa wireplumber man --noconfirm >> $log_file; 


    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

    case $1 in
        "wayland")
            sudo pacman -S grim wofi swaybg waybar swayidle swaylock wl-clipboard --noconfirm >> $log_file;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in 
                "S"* | "s"*)
                    sudo pacman -S sway i3blocks swaybg --noconfirm >> $log_file;
                    ;;
                "H"* | "h"*)
                    sudo pacman -S hyprland waybar hyprpaper --noconfirm >> $log_file;
                    ;;
                "R"* | "r"*)
                    sudo pacman -S river waybar swaybg --noconfirm >> $log_file;
                    ;;
            esac
            ;;
        *)
            sudo pacman -S xorg lxappearance xwallpaper picom xorg-xinput xorg-xinit xclip i3lock --noconfirm >> $log_file;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in 
                "I"* | "i"*)
                    sudo pacman -S i3 i3blocks --noconfirm >> $log_file;
                    ;;
                "A"* | "a"*)
                    sudo pacman -S awesome --noconfirm >> $log_file;
                    ;;
                "B"* | "b"*)
                    sudo pacman -S bspwm polybar sxhkd --noconfirm >> $log_file;
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

    



