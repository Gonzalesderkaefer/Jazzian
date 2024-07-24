#!/usr/bin/python

## Imports
import os
import subprocess
import re
import shutil


## Defining Functions
def debian_install(displayserver, windowmanager):

    print("Going to update and install predefined packages (see this script)")
    print("Press ENTER to Continue")

    input()

    subprocess.run(["sudo", "apt", "update"])
    subprocess.run(["sudo", "apt", "upgrade"])

    debian_wayland_packages = [
        "grim", "tmux", "swaylock", "zsh", "file-roller", "evince",
        "flatpak", "network-manager", "network-manager-gnome",
        "network-manager-openconnect-gnome", "eom", "network-manager-openconnect",
        "lxappearance", "git", "lf", "neovim", "fonts-jetbrains-mono", "firefox-esr", "tlp", 
        "alacritty", "brightnessctl", "pipewire", "pipewire-alsa", "wofi", "pipewire-pulse",
        "fonts-material-design-icons-iconfont", "fonts-font-awesome", "xwayland",
        "libglib2.0-bin", "fonts-noto-color-emoji", "wlr-randr", "nala", "wl-clipboard",
        "mpv", "swayidle", "papirus-icon-theme", "gnome-themes-extra",
        "arc-theme", "libnotify-bin", "mako-notifier", "acpi-support", "acpid", "acpi"
        "linux-cpupower", "cpufrequtils", "openssh-server", "nnn", "fzf"
    ]

    debian_xorg_packages = [
        "vim", "picom", "rofi", "zsh", "network-manager",
        "network-manager-gnome", "network-manager-openconnect-gnome",
        "network-manager-openconnect", "alacritty", "pipewire", "xclip", "i3lock",
        "fonts-jetbrains-mono", "papirus-icon-theme", "arc-theme", "dunst", "libnotify-bin",
        "nnn", "fzf", "openssh-server", "nala", "xorg", "lxappearance", "xinput", "zathura", "xwallpaper",
        "pipewire-alsa", "pipewire-pulse"
    ]


    
    match displayserver:
        case _ if re.match(r'W.*|w.*', displayserver):
            subprocess.run(["sudo", "apt", "install"] + debian_wayland_packages)

            match windowmanager:
                case _ if re.match(r's.*|S.*', windowmanager):
                    subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"])

                case _ if re.match(r'r.*|R.*', windowmanager):
                    subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"])

                case _ if re.match(r'h.*|H.*', windowmanager):
                    subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"])
                    
                case _: 
                    subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"])

                    

        case _ if re.match(r'X.*|x.*', displayserver):
            subprocess.run(["sudo", "apt", "install"] + debian_xorg_packages)

            match windowmanager:
                case _ if re.match(r'i.*|I.*', windowmanager):
                    subprocess.run(["sudo", "apt", "install", "i3", "i3blocks"])

                case _ if re.match(r'a.*|A.*', windowmanager):
                    subprocess.run(["sudo", "apt", "install", "awesome"])

                case _ if re.match(r'b.*|B.*', windowmanager):
                    subprocess.run(["sudo", "apt", "install", "bspwm", "polybar", "sxhkd"])

                case _: 
                    subprocess.run(["sudo", "apt", "install", "i3", "i3blocks"])

        case _:
            subprocess.run(["sudo", "apt", "install"] + debian_xorg_packages)

            match windowmanager:
                case _ if re.match(r'i.*|I.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "i3", "i3blocks"])

                case _ if re.match(r'a.*|A.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "awesome"])

                case _ if re.match(r'b.*|B.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "bspwm", "polybar", "sxhkd"])

                case _: 
                    subprocess.run(["sudo", "dnf", "install", "i3", "i3blocks"])




def fedora_install(displayserver, windowmanager):

    fedora_wayland_packages = [
        "i3blocks", "grim", "tmux", "swaybg", "swayidle", "zsh",
        "swaylock", "pinentry", "thunar", "polkit-gnome", "nnn", "neovim",
        "waybar", "alacritty", "mpv", "firefox", "zathura", "zathura-pdf-poppler", "evince",
        "git", "pipewire", "pipewire-utils", "file-roller", "pipewire-pulseaudio",
        "NetworkManager-openconnect-gnome", "wofi", "brightnessctl",
        "gsettings-desktop-schemas", "wl-clipboard", "papirus-icon-theme",
        "NetworkManager-tui", "eom", "tlp", "libnotify", "mako", "pipewire-alsa",
        "google-noto-color-emoji-fonts", "qalculate-gtk", "fzf", "hyprpaper",
        "jetbrains-mono-fonts", "lxappearance", "papirus-icon-theme-dark",
        "network-manager-applet"
    ]

    fedora_xorg_packagess = [
        "tmux", "zsh", "rofi",
        "pinentry", "thunar", "polkit-gnome", "nnn", "neovim",
        "alacritty", "mpv", "firefox", "zathura", "zathura-pdf-poppler", "evince",
        "git", "pipewire", "pipewire-utils", "file-roller",
        "NetworkManager-openconnect-gnome", "brightnessctl",
        "gsettings-desktop-schemas", "xclip", "papirus-icon-theme",
        "NetworkManager-tui", "eom", "tlp", "libnotify", "dunst",
        "google-noto-color-emoji-fonts", "qalculate-gtk", "fzf", "@base-x",
        "jetbrains-mono-fonts", "lxappearance", "papirus-icon-theme-dark",
        "network-manager-applet"
    ]

    match displayserver:
        case _ if re.match(r'W.*|w.*', displayserver):
            subprocess.run(["sudo", "dnf", "install"] + fedora_wayland_packages)

            match windowmanager:
                case _ if re.match(r's.*|S.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "sway", "i3blocks"])

                case _ if re.match(r'r.*|R.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "river", "waybar"])

                case _ if re.match(r'h.*|H.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "hyprland", "waybar"])
                    
                case _: 
                    subprocess.run(["sudo", "dnf", "install", "sway", "i3blocks"])

                    

        case _ if re.match(r'X.*|x.*', displayserver):
            subprocess.run(["sudo", "dnf", "install"] + fedora_xorg_packages)

            match windowmanager:
                case _ if re.match(r'i.*|I.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "i3", "i3blocks"])

                case _ if re.match(r'a.*|A.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "awesome"])

                case _ if re.match(r'b.*|B.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "bspwm", "polybar", "sxhkd"])

                case _: 
                    subprocess.run(["sudo", "dnf", "install", "i3", "i3blocks"])

        case _:
            subprocess.run(["sudo", "dnf", "install"] + fedora_xorg_packages)

            match windowmanager:
                case _ if re.match(r'i.*|I.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "i3", "i3blocks"])

                case _ if re.match(r'a.*|A.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "awesome"])

                case _ if re.match(r'b.*|B.*', windowmanager):
                    subprocess.run(["sudo", "dnf", "install", "bspwm", "polybar", "sxhkd"])

                case _: 
                    subprocess.run(["sudo", "dnf", "install", "i3", "i3blocks"])



def arch_install(displayserver, windowmanager):


    arch_wayland_packages = [
        "fzf", "grim", "tmux", "zsh", "nnn", "networkmanager",
        "nm-connection-editor", "neovim", "wofi", "zathura-pdf-poppler", "zathura",
        "evince", "webkit2gtk-4.1", "networkmanager-openconnect", "firefox", "lf", "tlp",
        "alacritty", "pipewire", "waybar", "mpv", "gsettings-desktop-schemas", "network-manager-applet",
        "swayidle", "swaylock", "openconnect", "lxappearance", "wl-clipboard", "file-roller",
        "papirus-icon-theme", "gnome-themes-extra", "arc-gtk-theme", "ttf-jetbrains-mono",
        "ttf-jetbrains-mono-nerd", "gcr", "bash-completion", "zsh-completions", "gcc", "less", "wget",
        "pipewire-pulse", "pipewire-alsa", "wireplumber", "man"
    ]

    arch_xorg_packages = [
        "neovim", "picom", "i3blocks", "rofi", "zsh", "networkmanager",
        "alacritty", "pipewire", "xclip", "i3lock", "networkmanager-openconnect", "network-manager-applet",
        "papirus-icon-theme", "arc-gtk-theme", "dunst", "libnotify", "xorg-xinit",
        "nnn", "fzf", "xorg", "lxappearance", "xorg-xinput", "zathura", "zathura-pdf-poppler", "xwallpaper",
        "webkit2gtk-4.1", "ttf-jetbrains-mono", "ttf-jetbrains-mono-nerd", "gcr",
        "bash-completion", "zsh-completions", "gcc", "less", "wget", "pipewire-pulse",
        "pipewire-alsa", "wireplumber", "man"
    ]


    match displayserver:
        case _ if re.match(r'W.*|w.*', displayserver):
            subprocess.run(["sudo", "pacman", "-S"] + arch_wayland_packages)

            match windowmanager:
                case _ if re.match(r's.*|S.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "sway", "i3blocks", "swaybg"])

                case _ if re.match(r'r.*|R.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "river", "waybar", "swaybg"])

                case _ if re.match(r'h.*|H.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "hyprland", "waybar", "hyprpaper"])
                    
                case _: 
                    subprocess.run(["sudo", "pacman", "-S", "sway", "i3blocks", "swaybg"])

                    

        case _ if re.match(r'X.*|x.*', displayserver):
            subprocess.run(["sudo", "pacman", "-S"] + arch_xorg_packages)

            match windowmanager:
                case _ if re.match(r'i.*|I.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "i3", "i3blocks"])

                case _ if re.match(r'a.*|A.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "awesome"])

                case _ if re.match(r'b.*|B.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "bspwm", "polybar", "sxhkd"])

                case _: 
                    subprocess.run(["sudo", "pacman", "-S", "i3", "i3blocks"])

        case _:
            subprocess.run(["sudo", "pacman", "-S"] + arch_xorg_packages)

            match windowmanager:
                case _ if re.match(r'i.*|I.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "i3", "i3blocks"])

                case _ if re.match(r'a.*|A.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "awesome"])

                case _ if re.match(r'b.*|B.*', windowmanager):
                    subprocess.run(["sudo", "pacman", "-S", "bspwm", "polybar", "sxhkd"])

                case _: 
                    subprocess.run(["sudo", "pacman", "-S", "i3", "i3blocks"])




def copy_files():
    # Get Home directory
    HOME = os.environ["HOME"]
    # Get config dir
    CFG_FILES = os.getcwd()+"/cfg_files"
    # Get bin dir
    BIN_FILES = os.getcwd()+"/bin"

    # check if .config exists in HOME
    if not ".config" in os.listdir(HOME):
        os.mkdir(HOME + "/.config")
    
    # check if .local exists in HOME
    if not ".local" in os.listdir(HOME):
        os.mkdir(HOME + "/.local")

    # check if bin exists in HOME/.local
    if not "bin" in os.listdir(HOME + "/.local"):
        os.mkdir(HOME + "/.local/bin")

    illegal_files = ["X11", "passgen", "shell", "nnn_plugins",]

    for file in os.listdir(CFG_FILES):
        if not file in illegal_files:
            shutil.copy(CFG_FILES+"/"+file, HOME+"/.config/"+file)
    
    # config files for nnn
    if not "nnn" in os.listdir(HOME+"/.config"):
        os.mkdir(HOME + "/.config/nnn")

    if "plugins" in os.listdir(HOME + "/.config/nnn"):
        os.remove(HOME + "/.config/nnn/plugins")
    shutil.copy(CFG_FILES+"/nnn_plugins", HOME+"/.config/nnn/plugins")

    # copy bash config files
    for file in os.listdir(CFG_FILES+"/shell/bash"):
        shutil.copy(CFG_FILES+"/shell/bash/"+file, HOME+"."+file)

    # copy zsh config files
    for file in os.listdir(CFG_FILES+"/shell/zsh"):
        shutil.copy(CFG_FILES+"/shell/zsh/"+file, HOME+"."+file)

    # copy scripts
    for file in os.listdir(BIN_FILES):
        shutil.copy(BIN_FILES+"/"+file, HOME+".local/bin/"+file)
