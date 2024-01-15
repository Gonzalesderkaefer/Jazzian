#!/bin/bash

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install i3-wm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nitrogen rofi picom file-roller evince flatpak polybar cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd neovim xorg fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer xinput gnome-themes-extra arandr fonts-material-design-icons-iconfont fonts-font-awesome lf libglib2.0-bin

#setting default applications
xdg-mime default org.gnome.Evince.desktop application/pdf


if [ -z "$(ls $HOME/.local/ | grep -o bin)" ]; 
then
	mkdir -p $HOME/.local/bin
fi


#copying config files
cp -r $HOME/Jazzian/cfg_files/alacritty/ $HOME/.config/alacritty/
cp -r $HOME/Jazzian/cfg_files/i3/ $HOME/.config/
cp -r $HOME/Jazzian/cfg_files/picom/ $HOME/.config/picom/
cp -r $HOME/Jazzian/cfg_files/rofi/ $HOME/.config/rofi/
cp -r $HOME/Jazzian/cfg_files/polybar/ $HOME/.config/polybar/
cp -r $HOME/Jazzian/bin/* $HOME/.local/bin/
sudo cp -r $HOME/Jazzian/etc/lightdm/ /etc/



#making rc-files executable
chmod +x $HOME/.config/bspwm/bspwmrc
chmod +x $HOME/.config/sxhkd/sxhkdrc

#systemd
sudo systemctl enable tlp
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target

#Shell config
echo 'alias "ll"="ls -la"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "sn"="sudo nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "n"="nala"' >> HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "shutdown"="systemctl poweroff"' >> HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "reboot"="systemctl reboot"' >> HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
