#!/bin/sh

# Constants
BACKUP_DIR="$HOME/custom_backups";
CUSTOM="devicespecific";
CUSTOM_THEME="devicespecific_theme";




create() {
    # Create BACKUP_DIR if not exists
    [ -d $BACKUP_DIR ] || mkdir $BACKUP_DIR;

    # i3 backup
    [ -d $BACKUP_DIR/i3 ] || mkdir $BACKUP_DIR/i3;
    [ -d $HOME/.config/i3/$CUSTOM ] && cp -r $HOME/.config/i3/$CUSTOM/* $BACKUP_DIR/i3/;

    # awesomewm backup
    [ -d $BACKUP_DIR/awesome ] || mkdir $BACKUP_DIR/awesome;
    [ -d $HOME/.config/awesome/$CUSTOM ] && cp -r $HOME/.config/awesome/$CUSTOM/* $BACKUP_DIR/awesome/

    # bspwm backup
    [ -d $BACKUP_DIR/bspwm ] || mkdir $BACKUP_DIR/bspwm;
    [ -d $HOME/.config/bspwm/$CUSTOM ] && cp $HOME/.config/bspwm/$CUSTOM/* $BACKUP_DIR/bspwm/

    # Hyprland backup
    [ -d $BACKUP_DIR/hypr ] || mkdir $BACKUP_DIR/hypr;
    [ -d $HOME/.config/hypr/$CUSTOM ] && cp $HOME/.config/hypr/$CUSTOM/* $BACKUP_DIR/hypr/

    # sway backup
    [ -d $BACKUP_DIR/sway ] || mkdir $BACKUP_DIR/sway;
    [ -d $HOME/.config/sway/$CUSTOM ] && cp $HOME/.config/sway/$CUSTOM/* $BACKUP_DIR/sway/

    # river backup
    [ -d $BACKUP_DIR/river ] || mkdir $BACKUP_DIR/river;
    [ -d $HOME/.config/sway/$CUSTOM ] && cp $HOME/.config/sway/$CUSTOM/* $BACKUP_DIR/river/

    # nvim backup
    [ -d $BACKUP_DIR/nvim ] || mkdir $BACKUP_DIR/nvim;
    [ -f $HOME/.config/nvim/lua/mycfg/$CUSTOM.lua ] && cp $HOME/.config/nvim/lua/mycfg/$CUSTOM.lua $BACKUP_DIR/nvim/
    
    # vim backup
    [ -d $BACKUP_DIR/vim ] || mkdir $BACKUP_DIR/vim;
    [ -f $HOME/.vim/$CUSTOM ] &&  cp $HOME/.vim/$CUSTOM $BACKUP_DIR/vim

    # x11startup backup
    [ -f $HOME/.local/bin/x11startup ] && cp $HOME/.local/bin/x11startup $BACKUP_DIR/
}

apply() {
    
    # i3 backup
    cp -r $BACKUP_DIR/i3/* $HOME/.config/i3/devicespecific/

    # awesomewm backup
    cp -r $BACKUP_DIR/awesome/* $HOME/.config/awesome/devicespecific/

    # bspwm backup
    cp -r $BACKUP_DIR/bspwm/* $HOME/.config/bspwm/devicespecific/

    # Hyprland backup
    cp -r $BACKUP_DIR/hypr/* $HOME/.config/hypr/devicespecific/

    # sway backup
    cp -r $BACKUP_DIR/sway/* $HOME/.config/sway/devicespecific/

    # river backup
    cp -r $BACKUP_DIR/river/* $HOME/.config/river/devicespecific/

    # nvim backup
    cp -r $BACKUP_DIR/nvim/* $HOME/.config/nvim/lua/mycfg/
    
    # vim backup
    cp -r $BACKUP_DIR/vim/* $HOME/.vim/

    # x11startup backup
    cp $BACKUP_DIR/x11startup $HOME/.local/bin/
}


if ! [ -d $BACKUP_DIR ]; then
    echo "Creating Backup.."
    create
    exit
fi

echo "Would you like to create a Backup or restore one?"
echo "[B]ackup"
echo "[R]estore"

read backup_choice

case $backup_choice in 
    "r"* | "R"*)
        apply ;;
    "b"* | "B"*)
        create ;;
        *)
            echo "Invalid choice. Terminating.." ;;
esac



