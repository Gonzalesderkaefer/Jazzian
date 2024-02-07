#!/bin/sh

sudo dnf update && 
sudo dnf install hyprland swaybg swayidle swaylock pinentry-gtk pinentry\
thunar polkit-gnome nnn neovim waybar alacritty mpv firefox zathura zathura-pdf-poppler evince git pulseaudio-utils pipewire-utils file-roller\
NetworkManager-openconnect-gnome wofi brightnessctl gsettings-desktop-schemas wl-clipboard papirus-icon-theme NetworkManager-tui eom tlp\
libnotify mako swaybg


ls $HOME/.local/bin || mkdir -p $HOME/.local/bin/ #make directory if .local/bin does not exist
        
#copying scripts to .local/bin/
cp -r $HOME/Jazzian/bin/Wayland/* $HOME/.local/bin/
#copying config files
cp -r cfg_files/alacritty/ $HOME/.config/alacritty/
cp -r cfg_files/wofi/ $HOME/.config/
cp -r cfg_files/hypr/ $HOME/.config/
cp -r cfg_files/nvim/ $HOME/.config/
cp -r cfg_files/waybar/ $HOME/.config/ 
cp -r cfg_files/mako/ $HOME/.config/ 

cat $HOME/.config/waybar/config | sed -e 's/hyprland/sway/g' > $HOME/.config/waybar/config # probably not the best way to do this.

#systemd
sudo systemctl enable tlp
sudo systemctl set-default graphical.target

# bashrc
if [ "$SHELL" = "/bin/bash" ];
then
	echo '[ "$(tty)" = "/dev/tty1" ] && exec Hyprland' >> $HOME/.profile
	echo 'alias "ll"="ls -la"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
	echo 'alias "sn"="sudo nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
	echo 'alias "n"="nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
	echo 'alias "shutdown"="systemctl poweroff"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
	echo 'alias "reboot"="systemctl reboot"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
fi



