#!/bin/sh

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install rofi file-roller evince flatpak cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd lf neovim fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer sway waybar fonts-material-design-icons-iconfont fonts-font-awesome xwayland libglib2.0-bin fonts-noto-color-emoji wlr-randr nala wl-clipboard


#copying config files
cp -r alacritty/ $HOME/.config/alacritty/
cp -r rofi/ $HOME/.config/
cp -r sway/ $HOME/.config/
cp -r nvim/ $HOME/.config/
sudo cp -r waybar/ /etc/xdg/

#systemd
sudo systemctl enable tlp
sudo systemctl set-default graphical.target
