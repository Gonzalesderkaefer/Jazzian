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

debian_install()
{
    echo -e "$start_green Going to upgrade this system and install predfined packages $end_green";
    echo -e "$start_green This may take a while. Press ENTER to continue. $end_green";
    read continue;
    
    sudo apt update ;
    sudo apt upgrade -y ;
    echo -e "$start_green Update finished. Going to install general packages. $end_green";
    sleep 3;

    sudo apt install tmux zsh evince flatpak network-manager network-manager-gnome \
    thunar file-roller network-manager-openconnect-gnome eom network-manager-openconnect \
    git lf fonts-jetbrains-mono firefox-esr tlp pipewire pipewire-alsa \
    pipewire-pulse libglib2.0-bin nala mpv papirus-icon-theme gnome-themes-extra \
    arc-theme libnotify-bin acpi-support acpid acpi linux-cpupower cpufrequtils \
    openssh-server nnn fzf zathura -y ;

    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

    case $1 in 
        "wayland")
            sudo apt install grim swaylock wofi xwayland wlr-randr alacritty wl-clipboard swayidle \
            mako-notifier -y ;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in
                "river")
                    sudo apt install sway i3blocks -y ;
                    ;;
                "Hyprland")
                    sudo apt install sway i3blocks -y ;
                    ;;
                *)
                    sudo apt install sway i3blocks -y ;
                    ;;
            esac
            ;;
        *)
            sudo apt install lxappearance rofi arandr rofi xclip i3lock picom kitty dunst \
            xinput xorg xwallpaper -y ;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in
                "awesome")
                    sudo apt install awesome -y ;
                    ;;
                "bspwm")
                    sudo apt install bspwm sxhkd polybar -y ;
                    ;;
                *)
                    sudo apt install i3 i3blocks -y ;
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
    sudo dnf install rofi-wayland tmux zsh pinentry thunar polkit-gnome nnn neovim \
    mpv firefox zathura zathura-pdf-poppler evince git pipewire pipewire-utils \
    file-roller pipewire-pulseaudio NetworkManager-openconnect-gnome \
    gsettings-desktop-schemas papirus-icon-theme NetworkManager-tui eom tlp libnotify \
    pipewire-alsa qalculate-gtk fzf jetbrains-mono-fonts papirus-icon-theme-dark \
    network-manager-applet -y ;
 
    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

    case $1 in
        "wayland")
            sudo dnf install grim swaybg swayidle hyprlock waybar wofi wl-clipboard alacritty -y ;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
                
            case $2 in 
                "H"* | "h"*)
                    sudo dnf install hyprland waybar -y ;
                    ;;
                "R"* | "r"*)
                    sudo dnf install river waybar -y ;
                    ;;
                *)
                    sudo dnf install sway i3blocks -y ;
                    ;;
            esac
            ;;
        *)
            sudo dnf install xclip @base-x lxappearance nitrogen picom dunst xclip kitty -y ;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in 
                "A"* | "a"*)
                    sudo dnf install awesome -y ;
                    ;;
                "B"* | "b"*)
                    sudo dnf install bspwm polybar -y ;
                    ;;
                *)
                    sudo dnf install i3 i3blocks -y ;
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
    sudo pacman -S fzf tmux zsh nnn rofi-wayland networkmanager thunar nm-connection-editor \
    neovim zathura-pdf-poppler zathura evince webkit2gtk-4.1 networkmanager-openconnect \
    firefox lf tlp pipewire mpv gsettings-desktop-schemas network-manager-applet \
    openconnect lxappearance file-roller papirus-icon-theme gnome-themes-extra arc-gtk-theme \
    ttf-jetbrains-mono-nerd gcr bash-completion zsh-completions gcc less wget pipewire-pulse \
    pipewire-alsa wireplumber man --noconfirm --needed; 


    echo -e "$start_green Installed general packages. Going to install packages for $1 $end_green";
    sleep 3;

    case $1 in
        "wayland")
            sudo pacman -S grim wofi swaybg waybar swayidle hyprlock wl-clipboard alacritty --noconfirm --needed;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in 
                "H"* | "h"*)
                    sudo pacman -S hyprland waybar hyprpaper --noconfirm --needed;
                    ;;
                "R"* | "r"*)
                    sudo pacman -S river waybar swaybg --noconfirm --needed;
                    ;;
                *)
                    sudo pacman -S sway i3blocks swaybg --noconfirm --needed;
                    ;;
            esac
            ;;
        *)
            sudo pacman -S xorg lxappearance xwallpaper picom xorg-xinput xorg-xinit xclip kitty i3lock --noconfirm --needed;
            echo -e "$start_green Installed packages for $1. Going to install packages for your window manager  $end_green";
            sleep 3;
            case $2 in 
                "A"* | "a"*)
                    sudo pacman -S awesome --noconfirm --needed;
                    ;;
                "B"* | "b"*)
                    sudo pacman -S bspwm polybar sxhkd --noconfirm --needed;
                    ;;
                *)
                    sudo pacman -S i3 i3blocks --noconfirm --needed;
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

    



