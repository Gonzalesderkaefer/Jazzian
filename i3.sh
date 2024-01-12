#!/bin/bash

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install bspwm sxhkd lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings nitrogen rofi picom file-roller evince flatpak polybar cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd neovim xorg fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer xinput gnome-themes-extra arandr fonts-material-design-icons-iconfont fonts-font-awesome lf

#setting default applications
xdg-mime default org.gnome.Evince.desktop application/pdf


if [ -n "$(ls $HOME/.local/ | grep -o bin)" ]; 
then
	echo ".local/bin/ does not exist"
else
	mkdir $HOME/.local/bin
fi


#copying config files
ranger --copy-config=all
cp -r config/alacritty/ $HOME/.config/alacritty/
cp -r i3/ $HOME/.config/
cp -r picom $HOME/.config/picom/
cp -r rofi/ $HOME/.config/rofi/
cp -r polybar/ $HOME/.config/polybar/
cp -r bin/* $HOME/.local/bin/
sudo cp -r bspwm/etc/lightdm/ /etc/
sudo cp -r bspwm/etc/polybar/ /etc/



#making rc-files executable
chmod +x $HOME/.config/bspwm/bspwmrc
chmod +x $HOME/.config/sxhkd/sxhkdrc

#systemd
sudo systemctl enable tlp
sudo systemctl enable lightdm
sudo systemctl set-default graphical.target
sudo reboot

#Shell config
echo 'alias "ll"="ls -la"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "sn"="sudo nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "n"="nala"' >> HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "shutdown"="systemctl poweroff"' >> HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "reboot"="systemctl reboot"' >> HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
