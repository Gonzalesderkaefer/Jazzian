# Install script for Xorg (Debian only for now)

## Installing Packages

sudo apt install vim i3 picom i3blocks rofi zsh network-manager \
network-manager-gnome network-manager-openconnect-gnome \
network-manager-openconnect alacritty pulsemixer xclip i3lock \
fonts-jetbrains-mono papirus-icon-theme arc-theme dunst libnotify-bin \
nnn fzf openssh-server nala xorg lxappearance xinput zathura xwallpaper


## Make directory if .local/bin does not exist
ls $HOME/.local/bin || mkdir -p $HOME/.local/bin/

## create Pictures and screenshot dir if not existent
ls $HOME/Pictures/screenshots/ || mkdir -p $HOME/Pictures/screenshots

## If $HOME/.config does not exist make it
ls $HOME/.config/ || mkdir -p $HOME/.config/

## create .trash directory
mkdir $HOME/.trash/

## Ask user whether to copy or link configs and scripts 
echo "[C]opy or [L]ink the config files and scripts?"
read choice


case $choice in 
    'c' | 'C')
	echo -e "\033[0;32m copying config files...\033[0m "
	### Xorg specific
	cp -r $HOME/glowing-enigma/cfg_files/X11/bspwm $HOME/.config/
	cp -r $HOME/glowing-enigma/cfg_files/X11/dunst $HOME/.config/
	cp -r $HOME/glowing-enigma/cfg_files/X11/i3 $HOME/.config/
	cp -r $HOME/glowing-enigma/cfg_files/X11/picom $HOME/.config/
	cp -r $HOME/glowing-enigma/cfg_files/X11/polybar $HOME/.config/
	cp -r $HOME/glowing-enigma/cfg_files/X11/rofi $HOME/.config/
	cp -r $HOME/glowing-enigma/cfg_files/X11/sxhkd $HOME/.config/
	
	### Others
	cp $HOME/glowing-enigma/cfg_files/vim/vimrc $HOME/.vimrc
	cp  -r $HOME/glowing-enigma/cfg_files/nnn $HOME/.config/
	cp  -r $HOME/glowing-enigma/cfg_files/qutebrowser $HOME/.config/
	cp  -r $HOME/glowing-enigma/cfg_files/i3blocks $HOME/.config/
	cp  -r $HOME/glowing-enigma/cfg_files/zathura $HOME/.config/
	cp  -r $HOME/glowing-enigma/cfg_files/alacritty $HOME/.config/

	echo -e "\033[0;32m copying scipts to '~/.local/bin/ \033[0m"

	echo "Press ENTER to continue."
	cp -r $HOME/glowing-enigma/cfg_files/X11/bin/* $HOME/.local/bin/
	read cont
	;;
    'l' | 'L')
	### Xorg specific
	echo -e "\033[0;32m linking config files...\033[0m "
	ln -s $HOME/glowing-enigma/cfg_files/X11/bspwm $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/X11/dunst $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/X11/i3 $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/X11/picom $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/X11/polybar $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/X11/rofi $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/X11/sxhkd $HOME/.config/

	### Others
	ln $HOME/glowing-enigma/cfg_files/vim/vimrc $HOME/.vimrc
	ln -s $HOME/glowing-enigma/cfg_files/nnn $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/qutebrowser $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/i3blocks $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/zathura $HOME/.config/
	ln -s $HOME/glowing-enigma/cfg_files/alacritty $HOME/.config/

	echo -e "\033[0;32m linking scipts to '~/.local/bin/ \033[0m"

	echo "Press ENTER to continue."
	ln -s $HOME/glowing-enigma/cfg_files/X11/bin/* $HOME/.local/bin/
	read cont
	;;
esac


## Determinig what shell is running

case "$SHELL" in 
    *"bash"*)
	echo -e "\033[0;32m found bash \033[0m"
	cp $HOME/glowing-enigma/cfg_files/shell/bash/bashrc $HOME/.bashrc
	cp $HOME/glowing-enigma/cfg_files/shell/bash/profile $HOME/.bash_profile
	cp $HOME/glowing-enigma/cfg_files/shell/bash/bash_aliases $HOME/.bash_aliases
	echo '[ "$(tty)" = "/dev/tty1" ] && exec startx' >> $HOME/.bash_profile
	;;
    *"zsh"*)
	echo -e "\033[0;32m found zsh \033[0m"
	cp $HOME/glowing-enigma/cfg_files/shell/zsh/zshrc $HOME/.zshrc
	cp $HOME/glowing-enigma/cfg_files/shell/zsh/zshenv $HOME/.zshenv
	cp $HOME/glowing-enigma/cfg_files/shell/zsh/zprofile $HOME/.zprofile
	cp $HOME/glowing-enigma/cfg_files/shell/zsh/zcompdump $HOME/.zcompdump
	echo '[ "$(tty)" = "/dev/tty1" ] && exec startx' >> $HOME/.zprofile
	;;
esac







