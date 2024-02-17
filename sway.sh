#!/bin/sh

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install swaylock file-roller evince flatpak cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome eom network-manager-openconnect lxappearance git lf neovim fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer sway wofi waybar fonts-material-design-icons-iconfont fonts-font-awesome xwayland libglib2.0-bin fonts-noto-color-emoji wlr-randr nala wl-clipboard mpv swayidle papirus-icon-theme gnome-themes-extra pulseaudio arc-theme libnotify-bin mako-notifier acpi-support acpid acpi linux-cpupower cpufrequtils openssh-server&&

#copying scripts to .local/bin

if [ -z "$(ls $HOME/.local/ | grep -o bin)" ] #make directory if .local/bin does not exist
then
        mkdir -p $HOME/.local/bin/
fi
#copying scripts to .local/bin/
cp -r $HOME/Jazzian/bin/Wayland/* $HOME/.local/bin/
#copying config files
cp -r cfg_files/alacritty/ $HOME/.config/
cp -r cfg_files/wofi/ $HOME/.config/
cp -r cfg_files/sway/ $HOME/.config/
cp -r cfg_files/nvim/ $HOME/.config/
cp -r cfg_files/waybar/ $HOME/.config/ 
cp -r cfg_files/mako/ $HOME/.config/ 
cp -r cfg_files/lf/ $HOME/.config/ 



#systemd
sudo systemctl enable tlp
sudo systemctl enable ssh.service
sudo systemctl set-default graphical.target

#shell configuration
echo '[ "$(tty)" = "/dev/tty1" ] && exec sway' >> $HOME/.profile
echo 'alias "ll"="ls -la"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "sn"="sudo nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "n"="nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "shutdown"="systemctl poweroff"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "reboot"="systemctl reboot"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
