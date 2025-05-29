#!/bin/sh


debian_install()
{
    sudo apt update && sudo apt upgrade;
    sudo apt install git nala vim nnn tmux zsh alacritty lf fzf neovim wofi rofi;
}

arch_install()
{
    sudo pacman -Syu;
    sudo pacman -S neovim git tmux nnn lf alacritty fzf wofi rofi vim zsh 
}

fedora_install()
{
    sudo dnf update;
    sudo dnf install neovim git tmux nnn lf alacritty fzf wofi rofi vim zsh
}

copy_files()
{
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.config


    echo -e  "\033[0;32m Going to copy files in $HOME/Jazzian/cfg_files to $HOME/.config (see this script) \033[0m ";
    declare -a illegal_files=(
            "$HOME/Jazzian/cfg_files/X11" 
            "$HOME/Jazzian/cfg_files/passgen" 
            "$HOME/Jazzian/cfg_files/shell"
            "$HOME/Jazzian/cfg_files/nnn_plugins"
            );
    
    for file in $HOME/Jazzian/cfg_files/*; do
        if ! [[ ${illegal_files[@]} =~ $file ]]; then
            cp -r -f $file $HOME/.config/;
        fi
    done

    ### Config files for nnn
    mkdir -p $HOME/.config/nnn/
    ln cp -r $HOME/Jazzian/cfg_files/nnn_plugins $HOME/.config/nnn/plugins

    for x11_file in $HOME/Jazzian/cfg_files/X11/*; do
        cp -r -f $x11_file $HOME/.config/;
    done

    ### Copy bash config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/bash/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$*$")"
        cp -f $sh_file $HOME/.$filename;
    done

    ### Copy zsh config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/zsh/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
        cp $sh_file $HOME/.$filename;
    done

    ### Copying scripts 
    for script in $HOME/Jazzian/bin/*; do
        cp $script $HOME/.local/bin/;
    done
}

############################## HERE THE SCRIPT STARTS ##############################

## Determining if BASH is actually used
shell="$(ps $$)"

case $shell in 
    *"bash"* )
        echo "You are good to go";
        ;;
    *"zsh")
        echo "You are good to go";
        ;;
    *)
        echo "Please run this script using bash or zsh (bash install.sh or zsh install.sh)";
        exit;
esac


## Determining if script is in correct directory
if [ "$(pwd)" != "$HOME/Jazzian" ]; then
    echo -e "\033[0;31m You seem to have run the script not from within the 'Jazzian' \033[0m";
    echo -e "\033[0;31m directory or the 'Jazzian' directory is not in your HOME \033[0m";
    echo -e 
    echo -e "\033[0;31m Please make sure the 'Jazzian' directory is in you HOME \033[0m";
    echo -e "\033[0;31m And make sure the script is run from within 'Jazzian' \033[0m";
    exit;
fi


# Determining what distro is running 
release="$(cat /etc/os-release)";

echo -e "\033[0;32m Determining Distro ... \033[0m ";

case $release in
    *"Debian"* | *"debian"* | *"DEBIAN"*) 
        echo -e  "\033[0;32m Found Debian.\033[0m ";
        debian_install
        ;;
    *"Fedora"* | *"fedora"* | *"FEDORA"*) 
        echo -e  "\033[0;32m Found Fedora.\033[0m ";
        fedora_install
        ;;
    *"Arch Linux"* | *"arch linux"* | *"ARCH LINUX"*) 
        echo -e  "\033[0;32m Found Arch Linux.\033[0m ";
        arch_install
        ;;
esac



# creating devicespecific files
if ! [ -f $HOME/.devicerc ]; then
    touch $HOME/.devicerc
fi

echo -e  "\033[0;32m |****** Script has finished ******| \033[0m ";
