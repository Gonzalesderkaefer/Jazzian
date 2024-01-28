#Arch Linux Packages

sudo pacman -S neovim sway waybar wofi zathura-pdf-poppler zathura evince webkit2gtk-4.1 networkmanager-openconnect firefox lf tlp alacritty pulseaudio pulsemixer waybar mpv gsettings-desktop-schemas nerd-fonts swayidle swaylock openconnect lxappearance wl-clipboard file-roller papirus-icon-theme gnome-themes-extra arc-gtk-theme

#copying scripts to .local/bin

if [ -z "$(ls $HOME/.local/ | grep -o bin)" ] #make directory if .local/bin does not exist
then
        mkdir -p $HOME/.local/bin/
fi
#copying scripts to .local/bin/
cp -r $HOME/Jazzian/bin/Wayland/* $HOME/.local/bin/
#copying config files
cp -r cfg_files/alacritty/ $HOME/.config/alacritty/
cp -r cfg_files/wofi/ $HOME/.config/
cp -r cfg_files/sway/ $HOME/.config/
cp -r cfg_files/nvim/ $HOME/.config/
cp -r cfg_files/waybar/ $HOME/.config/ 



#systemd
sudo systemctl enable tlp
