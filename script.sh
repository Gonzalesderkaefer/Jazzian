#!/bin/bash

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install bspwm sxhkd lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nitrogen rofi picom file-roller evince flatpak polybar cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd neovim xorg fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer xinput gnome-themes-extra arandr fonts-material-design-icons-iconfont fonts-font-awesome lf
#setting default applications
xdg-mime default org.gnome.Evince.desktop application/pdf

#copying config files
ranger --copy-config=all
cp -r config/alacritty/ $HOME/.config/alacritty/
cp -r config/bspwm $HOME/.config/bspwm/
cp -r config/sxhkd/ $HOME/.config/sxhkd/
cp -r config/picom $HOME/.config/picom/
cp -r config/rofi/ $HOME/.config/rofi/
cp -r config/polybar/ $HOME/.config/polybar/
sudo cp -r etc/lightdm/ /etc/
sudo cp -r etc/polybar/ /etc/

#making rc-files executable
chmod +x $HOME/.config/bspwm/bspwmrc
chmod +x $HOME/.config/sxhkd/sxhkdrc

#systemd
sudo systemctl enable tlp
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target
sudo reboot
