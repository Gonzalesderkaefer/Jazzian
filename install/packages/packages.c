// Other files
#include "../def.h"

// Debian standard packages
static const char *debstd[] = {
  "tmux",
  "vifm",
  "zsh",
  "evince",
  "flatpak",
  "network-manager",
  "network-manager-gnome",
  "thunar",
  "file-roller",
  "network-manager-openconnect-gnome",
  "eom",
  "network-manager-openconnect",
  "git",
  "lf",
  "fonts-jetbrains-mono",
  "firefox-esr",
  "tlp",
  "alacritty",
  "pipewire",
  "pipewire-alsa",
  "pipewire-pulse",
  "libglib2.0-bin",
  "nala",
  "mpv",
  "papirus-icon-theme",
  "gnome-themes-extra",
  "arc-theme",
  "libnotify-bin",
  "acpi-support",
  "acpid",
  "acpi",
  "linux-cpupower",
  "cpufrequtils",
  "openssh-server",
  "nnn",
  "fzf",
  "zathura",
  NULL
};

// Debian xorg packages
static const char *debxorg[] = {
  "lxappearance",
  "maim",
  "rofi",
  "arandr",
  "rofi",
  "xclip",
  "i3lock",
  "picom",
  "dunst",
  "xinput",
  "xorg",
  "xwallpaper",
  "rxvt-unicode",
  "nitrogen",
  NULL
};

// Debian i3 packages
static const char *debi3[] = {
  "i3",
  "i3blocks",
  NULL
};

// Debian bspwm packages
static const char *debbspwm[] = {
  "bspwm",
  "sxhkd",
  "polybar",
  NULL
};

// Debian awesome packages
static const char *debawesome[] = {
  "awesome",
  NULL
};



// Debian wayland packages
static const char *debwlnd[] = {
  "grim",
  "swaylock",
  "wofi",
  "xwayland",
  "wlr-randr",
  "wl-clipboard",
  "swayidle",
  "mako-notifier",
  "slurp",
  NULL
};

// Debian sway packages
static const char *debsway[] = {
  "sway",
  "i3block",
  NULL
};

// Debian hyprland packages
static const char *debhypr[] = {
  "sway",
  "i3block",
  NULL
};

// Debian river packages
static const char *debriver[] = {
  "sway",
  "i3block",
  NULL
};

// Fedora standard packages
static const char *fedstd[] = {
  "rofi-wayland",
  "vifm",
  "tmux",
  "zsh",
  "pinentry",
  "thunar",
  "mate-polkit",
  "nnn",
  "neovim",
  "alacritty",
  "mpv",
  "firefox",
  "zathura",
  "zathura-pdf-poppler",
  "evince",
  "git",
  "pipewire",
  "pipewire-utils",
  "file-roller",
  "pipewire-pulseaudio",
  "NetworkManager-openconnect-gnome",
  "gsettings-desktop-schemas",
  "papirus-icon-theme",
  "NetworkManager-tui",
  "eom",
  "tlp",
  "libnotify",
  "pipewire-alsa",
  "qalculate-gtk",
  "fzf",
  "jetbrains-mono-fonts",
  "papirus-icon-theme-dark",
  "network-manager-applet",
  "arc-theme",
  NULL

};

// Fedora xorg packages
static const char *fedora_xorg[] = {
  "xclip",
  "@base-x",
  "maim",
  "lxappearance",
  "xinput",
  "arandr",
  "nitrogen",
  "picom",
  "dunst",
  "xclip",
  "i3lock",
  "rxvt-unicode",
  "nitrogen",
  NULL
};

// Fedora awesome packages
static const char *fedora_awesome[] = {
  "awesome",
  NULL
};

// Fedora bspwm packages
static const char *fedora_bspwm[] = {
  "bspwm",
  "polybar",
  "sxhkd",
  NULL
};

// Fedora i3 packages
static const char *fedora_i3[] = {
  "i3",
  "i3blocks",
  NULL
};

// Fedora wayland packages
static const char *fedora_wayland[] = {
  "grim",
  "swaybg",
  "swayidle",
  "waybar",
  "wofi",
  "wl-clipboard",
  "swaylock",
  "mako",
  "slurp",
  NULL
};


// Fedora hyprland packages
static const char *fedora_hypr[] = {
  "hyprland",
  "waybar",
  NULL
};

// Fedora river packages
static const char *fedora_river[] = {
  "river",
  "waybar",
  NULL
};

// Fedora sway packages
static const char *fedora_sway[] = {
  "sway",
  "i3blocks",
  NULL
};

// Arch linux standard packages
static const char *archstd[] = {
  "fzf",
  "tmux",
  "zsh",
  "vifm",
  "nnn",
  "rofi-wayland",
  "networkmanager",
  "thunar",
  "nm-connection-editor",
  "neovim",
  "zathura-pdf-poppler",
  "zathura",
  "evince",
  "webkit2gtk-4.1",
  "networkmanager-openconnect",
  "firefox",
  "lf",
  "tlp",
  "alacritty",
  "pipewire",
  "mpv",
  "gsettings-desktop-schemas",
  "eom",
  "network-manager-applet",
  "openconnect",
  "lxappearance",
  "file-roller",
  "papirus-icon-theme",
  "gnome-themes-extra",
  "arc-gtk-theme",
  "ttf-jetbrains-mono-nerd",
  "ttf-jetbrains-mono",
  "gcr",
  "bash-completion",
  "zsh-completions",
  "gcc",
  "less",
  "wget",
  "pipewire-pulse",
  "pipewire-alsa",
  "wireplumber",
  "cpupower",
  "git",
  NULL
};

// Arch xorg packages
static const char *arch_xorg[] = {
  "xorg",
  "lxappearance",
  "xwallpaper",
  "maim",
  "picom",
  "xorg-xinput",
  "xorg-xinit",
  "xclip",
  "i3lock",
  "rxvt-unicode",
  "nitrogen",
  NULL
};

// Arch awesome packages
static const char *arch_awesome[] = {
  "awesome",
  NULL
};

// Arch bspwm packages
static const char *arch_bspwm[] = {
  "bspwm",
  "polybar",
  "sxhkd",
  NULL
};

// Arch i3 packages
static const char *arch_i3[] = {
  "i3blocks",
  "i3",
  NULL
};


// Arch wayland packages
static const char *arch_wayland[] = {
  "grim",
  "wofi",
  "swaybg",
  "waybar",
  "swayidle",
  "swaylock",
  "wl-clipboard",
  "mako",
  "slurp",
  NULL
};

// Arch hyprland packages
static const char *arch_hypr[] = {
  "hyprland",
  "waybar",
  "hyprpaper",
  NULL
};

// Arch sway packages
static const char *arch_sway[] = {
  "sway",
  "i3blocks",
  "swaybg",
  NULL
};

// Arch river packages
static const char *arch_river[] = {
  "waybar",
  "river",
  "swaybg",
  NULL
};


int lst_len(const void **lst) {
  int len = 0;
  for (; lst[len] != NULL; ++len); 
  return len;
}

int main(){
  printf("%d\n",lst_len((const void **)arch_wayland));
}
