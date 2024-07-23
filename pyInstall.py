#!/usr/bin/python

## Imports
import os
import subprocess
import re


## Defining Functions
def debian_install(displayserver, windowmanager):

    print("Going to update and install predefined packages (see this script)")
    print("Press ENTER to Continue")

    input()

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

    # Regex for wayland
    wayland_regex = '^W.*|^w.*'

    # Regex for wayland
    xorg_regex = '^X.*|^x.*'

    chose_way = re.search(wayland_regex, displayserver)
    chose_xorg = re.search(xorg_regex, displayserver)

    if chose_way:
        # Regex for sway
        sway_regex = '^S.*|^s.*'
        chose_sway = re.search(sway_regex, windowmanager)

        # Regex for river
        river_regex = '^R.*|^r.*'
        chose_river = re.search(river_regex, windowmanager)

        # Regex for Hyprland
        hyprland_regex = '^H.*|^h.*'
        chose_hyprland = re.search(hyprland_regex, windowmanager)

        if chose_sway:
            subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"] + debian_wayland_packages)
        elif chose_river:
            subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"] + debian_wayland_packages)
        elif chose_hyprland:
            subprocess.run(["sudo", "apt", "install", "sway", "i3blocks"] + debian_wayland_packages)
        else:
            subprocess.run(debian_wayland_packages)


    elif chose_xorg:

        # Regex for i3
        i3_regex = '^i.*|^I.*'
        chose_i3 = re.search(i3_regex, windowmanager)

        # Regex for awesome
        awesome_regex = '^A.*|^a.*'
        chose_awesome = re.search(awesome_regex, windowmanager)

        # Regex for bspwm
        bspwm_regex = '^B.*|^b.*'
        chose_bspwm = re.search(hyprland_regex, windowmanager)

        if chose_i3:
            subprocess.run(["sudo", "apt", "install", "i3", "i3blocks"] + debian_xorg_packages)
        elif chose_awesome:
            subprocess.run(["sudo", "apt", "install", "awesome"] + debian_xorg_packages)
        elif chose_bspwm:
            subprocess.run(["sudo", "apt", "install", "bspwm", "polybar"] + debian_xorg_packages)
        else:
            subprocess.run(debian_xorg_packages)



