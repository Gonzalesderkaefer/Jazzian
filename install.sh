#!/bin/bash


# color variables
green="\033[0;32m"  
end_green="\033[0m "
red="\033[0;31m"
reset="\033[0m"



## Determining if BASH is actually used
shell="$(ps $$)"

case $shell in 
    *"bash"* )
        echo -e "$green You are using a good shell $reset";
        ;;
    *"zsh")
        echo -e "$green You are using a good shell $reset";
        ;;
    *)
        echo -e "$red Please run this script using bash or zsh (bash install.sh or zsh install.sh) $reset";
        exit;
esac


## Determining if script is in correct directory
if [ "$(pwd)" != "$HOME/Jazzian" ]; then
    echo -e "$red You seem to have run the script not from within the 'Jazzian' $reset";
    echo -e "$red directory or the 'Jazzian' directory is not in your HOME $reset";
    echo  
    echo -e "$red Please make sure the 'Jazzian' directory is in $HOME $reset";
    echo -e "$red And make sure the script is run from within 'Jazzian' $reset";
    exit;
fi



# configfile location
config_file=$HOME/Jazzian/modules/devicespecific.conf
renew_config="";


# run config script if config file does not exist
if ! [ -f $config_file ] && [ -f modules/config.sh ]; then
    bash $HOME/Jazzian/modules/config.sh
fi


# Ask user whether to renew config
if [ -f $config_file ] && [ -f modules/config.sh ]; then
    echo -e -n  "$green Would you like to rerun the configuration? [y/N]: $reset";
    read renew_config;
    case $renew_config in
        "y" | "Y")
            bash $HOME/Jazzian/modules/config.sh
            ;;
    esac
fi

# read config file and create variables
displayserver=$(grep -E  "Displayserver: " $config_file | awk '{print $2}');
windowmanager=$(grep -E  "Windowmanager: " $config_file | awk '{print $2}');
transfer=$(grep -E  "Transfer: " $config_file | awk '{print $2}');
distro=$(grep -E  "Distro: " $config_file | awk '{print $2}');

# Run package installer
if [ -f modules/pac_install.sh ];then
    bash modules/pac_install.sh $distro $displayserver $windowmanager;
else
    echo -e "$red Could not find pac_install script $reset"
fi


# Transfer dotfiles
if [ -f modules/move.sh ];then
    bash modules/move.sh $transfer;
else
    echo -e "$red Could not find move script $reset"
fi

# Create user-specific configs
if [ -f modules/custom.sh ];then
    bash modules/custom.sh $displayserver $windowmanager;
else
    echo -e "$red Could not find custom script $reset"
fi

# Ask user whether to install fonts

echo -e "$green Would you like to install the Jetbrains Mono Nerd Font?  $reset";
echo -e "$green This is needed for pretty much all configs. You can alternatively install it yourself  $reset";
echo -e "$green from their website.  $reset";
echo -e "$green [y/N] $reset";

read -p "Your Choice: " font_choice;

case $font_choice in
    "y"* | "Y"*)
        if [ -f modules/font_install.sh ];then
        bash modules/font_install.sh $distro;
        else
            echo -e "$red Could not find font script $reset"
        fi
        ;;
esac





