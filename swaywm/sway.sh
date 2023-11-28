#!/bin/bash

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install rofi file-roller atril flatpak cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd ranger neovim fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer sway waybar fonts-material-design-icons-iconfont fonts-font-awesome xwayland libglib2.0-bin

#special packages
sudo apt --no-install-recommends sddm


#copying config files
ranger --copy-config=all
cp -r alacritty/ $HOME/.config/alacritty/
cp -r rofi/ $HOME/.config/
cp -r sway $HOME/.config/
sudo cp -r waybar/ /etc/xdg/

#systemd
sudo systemctl enable tlp
sudo systemctl enable sddm
sudo systemctl set-default graphical.target
