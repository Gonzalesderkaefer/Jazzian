#!/bin/sh

#checking and applying updates
sudo apt update && sudo apt upgrade -y

#installing packages
sudo apt install rofi file-roller evince flatpak cbatticon network-manager network-manager-gnome network-manager-openconnect-gnome network-manager-openconnect lxappearance git snapd lf neovim fonts-jetbrains-mono firefox-esr tlp alacritty brightnessctl pulsemixer sway waybar fonts-material-design-icons-iconfont fonts-font-awesome xwayland libglib2.0-bin fonts-noto-color-emoji wlr-randr nala wl-clipboard mpv swayidle &&

#copying scripts to .local/bin

if [ -z "$(ls $HOME/.local/ | grep -o bin)" ] #make directory if .local/bin does not exist
then
        mkdir -p $HOME/.local/bin/
fi
#copying scripts to .local/bin/
cp -r $HOME/Jazzian/bin/Wayland/* $HOME/.local/bin/
#copying config files
cp -r cfg_files/alacritty/ $HOME/.config/alacritty/
cp -r cfg_files/sway/ $HOME/.config/
cp -r cfg_files/nvim/ $HOME/.config/
sudo cp -r cfg_files/waybar/ /etc/xdg/



#systemd
sudo systemctl enable tlp
sudo systemctl set-default graphical.target

#shell configuration
echo 'exec sway' >> $HOME/.profile
echo 'alias "ll"="ls -la"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "sn"="sudo nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "n"="nala"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "shutdown"="systemctl poweroff"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "reboot"="systemctl reboot"' >> $HOME/.$(echo $SHELL | awk -F '/' '{print $3}')rc
