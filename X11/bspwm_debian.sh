#!/bin/sh

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install bspwm sxhkd lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nitrogen rofi picom file-roller evince flatpak polybar cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd neovim xorg fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer xinput gnome-themes-extra arandr fonts-material-design-icons-iconfont fonts-font-awesome lf libglib2.0-bin arc-theme zathura 

#setting default applications
xdg-mime default org.gnome.Evince.desktop application/pdf
