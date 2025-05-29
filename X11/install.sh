#!/bin/bash

############################## DEFINING FUNCTIONS ##############################
debian_install()
{
    ## Checking for and Installing updates
    echo -e  "\033[0;32m Going to update and install predefined packages (see this script) \033[0m ";
    echo -e  "\033[0;32m ENTER to continue \033[0m ";
    read cont;

    sudo apt update && sudo apt upgrade -y;


case $1 in 
        'W'* | 'w'*)
            ### Installing wayland packages 
            sudo apt install grim tmux swaylock zsh evince \
            flatpak network-manager network-manager-gnome thunar file-roller  \
            network-manager-openconnect-gnome eom network-manager-openconnect \
            lxappearance git lf neovim fonts-jetbrains-mono firefox-esr tlp \
            alacritty brightnessctl pipewire pipewire-alsa wofi pipewire-pulse \
            fonts-material-design-icons-iconfont fonts-font-awesome xwayland \
            libglib2.0-bin fonts-noto-color-emoji wlr-randr nala wl-clipboard \
            mpv swayidle papirus-icon-theme gnome-themes-extra \
            arc-theme libnotify-bin mako-notifier acpi-support acpid acpi \
            linux-cpupower cpufrequtils openssh-server nnn fzf

            case $2 in 
                "S"* | "s"*)
                    sudo apt install sway i3blocks
                    ;;
                "H"* | "h"*)
                    sudo apt install sway i3blocks
                    ;;
                "R"* | "r"*)
                    sudo apt install sway i3blocks
                    ;;
            esac
                
            ;;
        'X'* | 'x'*)
            ### Installing xorg packages 
            sudo apt install vim picom rofi zsh network-manager  \
            network-manager-gnome network-manager-openconnect-gnome thunar file-roller \
            network-manager-openconnect alacritty pipewire xclip i3lock \
            fonts-jetbrains-mono papirus-icon-theme arc-theme dunst libnotify-bin \
            nnn fzf openssh-server nala xorg lxappearance xinput zathura xwallpaper \
            pipewire-alsa pipewire-pulse


            case $2 in 
                "I"* | "i"*)
                    sudo apt install i3 i3blocks
                    ;;
                "A"* | "a"*)
                    sudo apt install awesome
                    ;;
                "B"* | "b"*)
                    sudo apt install bspwm sxhkd
                    ;;
            esac
            ;;
    esac
}

arch_install()
{

    echo -e "\033[0;32m Going to update and install predefined packages(see this script) \033[0m "
    echo "Press ENTER to continue."
    read cont

    ### Checking and applying updates 
    sudo pacman -Syu

    case $1 in 
        'W'* | 'w'*)
            sudo pacman -S fzf grim tmux zsh nnn networkmanager thunar \
            nm-connection-editor neovim wofi zathura-pdf-poppler zathura \
            evince webkit2gtk-4.1 networkmanager-openconnect firefox lf tlp \
            alacritty pipewire waybar mpv gsettings-desktop-schemas network-manager-applet \
            swayidle swaylock openconnect lxappearance wl-clipboard file-roller \
            papirus-icon-theme gnome-themes-extra arc-gtk-theme ttf-jetbrains-mono \
            ttf-jetbrains-mono-nerd gcr bash-completion zsh-completions gcc less wget \
            pipewire-pulse pipewire-alsa wireplumber man;

            case $2 in 
                "S"* | "s"*)
                    sudo pacman -S sway i3blocks swaybg;
                    ;;
                "H"* | "h"*)
                    sudo pacman -S hyprland waybar hyprpaper;
                    ;;
                "R"* | "r"*)
                    sudo pacman -S river waybar swaybg;
                    ;;
            esac
            ;;
        'X'* | 'x'*)
            sudo pacman -S neovim picom i3blocks rofi zsh networkmanager thunar \
            alacritty pipewire xclip i3lock networkmanager-openconnect network-manager-applet \
            papirus-icon-theme arc-gtk-theme dunst libnotify xorg-xinit file-roller \
            nnn fzf xorg lxappearance xorg-xinput zathura zathura-pdf-poppler xwallpaper \
            webkit2gtk-4.1 ttf-jetbrains-mono ttf-jetbrains-mono-nerd gcr \
            bash-completion zsh-completions gcc less wget pipewire-pulse \
            pipewire-alsa wireplumber man;

            case $2 in 
                "I"* | "i"*)
                    sudo pacman -S i3 i3blocks;
                    ;;
                "A"* | "a"*)
                    sudo pacman -S awesome;
                    ;;
                "B"* | "b"*)
                    sudo pacman -S bspwm polybar sxhkd;
                    ;;
            esac
            ;;
    esac
}

fedora_install()
{
    ### Checking and applying updates 
    sudo dnf update;


     case $1 in
        'W'* | 'w'*)
            sudo dnf install i3blocks  grim tmux swaybg swayidle zsh \
            swaylock pinentry thunar polkit-gnome nnn neovim \
            waybar alacritty mpv firefox zathura zathura-pdf-poppler evince \
            git pipewire pipewire-utils file-roller pipewire-pulseaudio \
            NetworkManager-openconnect-gnome wofi brightnessctl \
            gsettings-desktop-schemas wl-clipboard papirus-icon-theme \
            NetworkManager-tui eom tlp libnotify mako pipewire-alsa \
            google-noto-color-emoji-fonts qalculate-gtk fzf hyprpaper \
            jetbrains-mono-fonts lxappearance papirus-icon-theme-dark \
            network-manager-applet

            case $2 in 
                "S"* | "s"*)
                    sudo dnf install sway i3blocks swaybg;
                    ;;
                "H"* | "h"*)
                    sudo dnf install hyprland waybar;
                    ;;
                "R"* | "r"*)
                    sudo dnf install river waybar swaybg;
                    ;;
            esac
            ;;
        'X'* | 'x'*)
            sudo dnf install tmux zsh rofi \
            pinentry thunar polkit-gnome nnn neovim \
            alacritty mpv firefox zathura zathura-pdf-poppler evince \
            git pipewire pipewire-utils file-roller \
            NetworkManager-openconnect-gnome brightnessctl \
            gsettings-desktop-schemas xclip papirus-icon-theme \
            NetworkManager-tui eom tlp libnotify dunst \
            google-noto-color-emoji-fonts qalculate-gtk fzf @base-x \
            jetbrains-mono-fonts lxappearance papirus-icon-theme-dark \
            network-manager-applet picom

            case $2 in 
                "I"* | "i"*)
                    sudo dnf install i3 i3blocks;
                    ;;
                "A"* | "a"*)
                    sudo dnf install awesome;
                    ;;
                "B"* | "b"*)
                    sudo dnf install bspwm polybar;
                    ;;
            esac
            ;;
    esac


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

link_files()
{
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.config

    echo -e  "\033[0;32m Going to copy files in $HOME/Jazzian/cfg_files to $HOME/.config (see this script) \033[0m ";
    declare -a illegal_files=(
            "$HOME/Jazzian/cfg_files/X11" 
            "$HOME/Jazzian/cfg_files/passgen" 
            "$HOME/Jazzian/cfg_files/shell"
            "$HOME/Jazzian/cfg_files/nnn_plugins"
            "$HOME/Jazzian/cfg_files/nvim"
            );
    ### Link general config files
    for file in $HOME/Jazzian/cfg_files/*; do
        if ! [[ ${illegal_files[@]} =~ $file ]]; then
            ln -sf $file $HOME/.config/;
        fi
    done

    ### Config files for nnn
    mkdir -p $HOME/.config/nnn/;

    if [ -z "$(ls $HOME/.config/nnn/)" ]; then
        ln -s "$HOME/Jazzian/cfg_files/nnn_plugins" $HOME/.config/nnn/plugins;
    fi


    ### Link X11 config files
    for x11_file in $HOME/Jazzian/cfg_files/X11/*; do
        ln -sf $x11_file $HOME/.config/;
    done

    ### Copy bash config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/bash/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
        ln -sf $sh_file $HOME/.$filename;
    done

    ### Copy zsh config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/zsh/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
        ln -sf $sh_file $HOME/.$filename;
    done

    ### Linking scripts 
    for script in $HOME/Jazzian/bin/*; do
        ln -sf $script $HOME/.local/bin/;
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


## Ask user whether wants Xorg or Wayland
continue="false";
echo -e "\033[0;32m Do you want to use [W]ayland or [X]org (Default: Xorg) \033[0m";

until [ $continue = "true" ]; do
    ## Making sure the user input is valid 
    read display_server;
    case $display_server in
        'W'* | 'w'* )
            display_server="wayland";
            continue="true";
            ;;
        'X'* | 'x'*)
            display_server="xorg";
            continue="true";
            ;;
        *)
            display_server="xorg";
            continue="true";
            ;;
    esac
done

echo $display_server;


## Ask user what Window Manager to install

continue="false";
until [ $continue = "true" ]; do
echo -e "\033[0;32m What WM would you like to use? \033[0m";
    case $display_server in
        'wayland')
            echo -e "\033[0;32m [S]way (default) \033[0m";
            echo -e "\033[0;32m [R]iver (Only on Fedora and Arch Linux)\033[0m";
            echo -e "\033[0;32m [H]yprland (Only on Fedora and Arch Linux)\033[0m";
            ;;
        'xorg')
            echo -e "\033[0;32m [i]3 (default) \033[0m";
            echo -e "\033[0;32m [A]wesomewm \033[0m";
            echo -e "\033[0;32m [B]spwm \033[0m";
            ;;
    esac

    read wm_choice;

    case $wm_choice in
        "S"* | "s"* | "R"* | "r"* | "H"* | "h"* )
            [ $display_server = "wayland" ] && continue="true" || 
                echo -e "\033[0;32m You can just enter the marked letter.\033[0m";
            ;;
        "I"* | "i"* | "A"* | "a"* | "B"* | "b"* )
            [ $display_server = "xorg" ] && continue="true" || 
                echo -e "\033[0;32m You can just enter the marked letter.\033[0m";
            ;;
        *)
            case $display_server in
                'wayland')
                    wm_choice=s;
                    ;;
                'xorg')
                    wm_choice=i;
                    ;;
            esac
            continue="true";
            ;;
    esac
done



# Determining what distro is running 
release="$(cat /etc/os-release)";

echo -e "\033[0;32m Determining Distro ... \033[0m ";

case $release in
    *"Debian"* | *"debian"* | *"DEBIAN"*) 
        echo -e  "\033[0;32m Found Debian.\033[0m ";
        debian_install $display_server $wm_choice
        ;;
    *"Fedora"* | *"fedora"* | *"FEDORA"*) 
        echo -e  "\033[0;32m Found Fedora.\033[0m ";
        fedora_install $display_server $wm_choice;
        ;;
    *"Arch Linux"* | *"arch linux"* | *"ARCH LINUX"*) 
        echo -e  "\033[0;32m Found Arch Linux.\033[0m ";
        arch_install $display_server $wm_choice;
        ;;
esac

# Ask user wheter to copy or to link the config files
continue="false";

until [ $continue = "true" ]; do
    echo -e "\033[0;32m Do you want to [C]opy, [L]ink or [S]kip the files? (Default Skip) \033[0m ";
read mov_choice; 

    case $mov_choice in
        "L"* | "l"*)
            link_files;
            continue="true";
            ;;
        "C"* | "c"*)
            copy_files; 
            continue="true";
            ;;
        "S"* | "s"*)
            echo -e "\033[0;32m Ok, skipping.. \033[0m ";
            echo  "Press ENTER to continue.";
            read continue;
            continue="true";
	    ;;
        *)
            echo -e "\033[0;32m Ok, skipping.. \033[0m ";
            echo  "Press ENTER to continue.";
            read continue;
            continue="true";
            ;;
    esac
done

echo -e "\033[0;32m Adding Devicesepcific configs and scripts for additional configuration from the user... \033[0m ";

### Creating files for i3
mkdir -p $HOME/.config/i3/devicespecific/;
[ -f  $HOME/.config/i3/devicespecific/devicespecific ] || touch $HOME/.config/i3/devicespecific/devicespecific;

### Creating files for awesomewm
[ -f  $HOME/.config/awesome/devicespecific.lua ] || touch $HOME/.config/awesome/devicespecific.lua;
[ -f  $HOME/.config/awesome/devicespecific_theme.lua ] || touch $HOME/.config/awesome/devicespecific_theme.lua;

### Creating files for BSPWM
mkdir -p $HOME/.config/bspwm/devicespecific/;
[ -f $HOME/.config/bspwm/devicespecific/devicespecific ] || ( touch $HOME/.config/bspwm/devicespecific/devicespecific;
echo '#!/bin/sh' >> $HOME/.config/bspwm/devicespecific/devicespecific );

### Creating files for Hyprland
mkdir -p $HOME/.config/hypr/devicespecific/;
[ -f $HOME/.config/hypr/devicespecific/devicespecific ] || touch $HOME/.config/hypr/devicespecific/devicespecific;

### Creating files for sway 
mkdir -p $HOME/.config/sway/devicespecific/;
[ -f $HOME/.config/sway/devicespecific/devicespecific ] || touch $HOME/.config/sway/devicespecific/devicespecific;

### Creating files for river 
mkdir -p $HOME/.config/river/devicespecific/;
[ -f $HOME/.config/river/devicespecific/devicespecific ] || touch $HOME/.config/river/devicespecific/devicespecific;



### Creating file for bash and zsh
#### devicerc
if ! [ -f $HOME/.devicerc ]; then
    touch $HOME/.devicerc
fi



if ! [ -f $HOME/.devicespecific.sh ]; then 
    touch $HOME/.devicespecific.sh;

    #### setting up devicespecific.sh
    echo 'shell_tokill="$(echo $SHELL | grep -E -o "[^\/]*$")"' >> $HOME/.devicespecific.sh
    echo 'shells=$(ps | grep -E "tty1.*$shell_tokill" | awk '\''{print $1}'\'')' >> $HOME/.devicespecific.sh


    echo 'killshells()' >> $HOME/.devicespecific.sh
    echo '{' >> $HOME/.devicespecific.sh
    echo '   for shell in $shells; do' >> $HOME/.devicespecific.sh
    echo '       kill -9 $shell;' >> $HOME/.devicespecific.sh
    echo '   done' >> $HOME/.devicespecific.sh
    echo '}' >> $HOME/.devicespecific.sh

    echo '[ "$(tty)" = "/dev/tty1" ] && (startx; killshells)' >> $HOME/.devicespecific.sh
fi

if ! [ -f $HOME/.xinitrc ]; then
    echo 'exec i3' >> $HOME/.xinitrc
fi

case $display_server in 
    "xorg")
        sed -i "s/\&\& (.*; killshells)/\&\& (startx; killshells) /g" $HOME/.devicespecific.sh
        case $wm_choice in
            "i"* | "I"*)
                sed -E -i "s/exec awesome|exec bspwm|exec i3/exec i3/g" $HOME/.xinitrc
                ;;
            "b"* | "B"*)
                sed -E -i "s/exec awesome|exec bspwm|exec i3/exec bspwm/g" $HOME/.xinitrc
                ;;
            "a"* | "A"*)
                sed -E -i "s/exec awesome|exec bspwm|exec i3/exec awesome/g" $HOME/.xinitrc
                ;;
        esac
        ;;

    "wayland")
        case $wm_choice in
            "r"* | "R"*)
                sed -i "s/\&\& (.*; killshells)/\&\& (river; killshells) /g" $HOME/.devicespecific.sh
                ;;
            "s"* | "S"*)
                sed -i "s/\&\& (.*; killshells)/\&\& (sway; killshells) /g" $HOME/.devicespecific.sh
                ;;
            "h"* | "H"*)
                sed -i "s/\&\& (.*; killshells)/\&\& (Hyprland; killshells) /g" $HOME/.devicespecific.sh
                ;;
        esac
        ;;
esac
        
echo -e  "\033[0;32m |****** Script has finished ******| \033[0m ";



# sed "s/\&\& (.*; killshells)/\&\& ($wm_choice; killshells) /g" .devicespecific.sh













