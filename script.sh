#!/bin/bash

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install bspwm sxhkd lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nitrogen rofi picom file-roller atril flatpak polybar cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd ranger neovim xorg fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer

#copying config files
ranger --copy-config=all
cp -r ~.config/alacritty/ $HOME/.config/alacritty/
cp -r ~.config/bspwm $HOME/.config/bspwm/
cp -r ~.config/sxhkd/ $HOME/.config/sxhkd/
cp -r ~.config/picom $HOME/.config/picom/
cp -r ~.config/rofi/ $HOME/.config/rofi/
sudo cp -r etc/lightdm/ /etc/
sudo cp -r etc/polybar/ /etc/

#systemd
sudo systemctl enable tlp
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target
