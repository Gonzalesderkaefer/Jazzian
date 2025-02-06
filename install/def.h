// Display server
typedef enum DISPLAYSERVER { XORG = 0, WAYLAND } DISPLAYSERVER;

// Windowmanager
typedef enum WINDOWMANAGER {
  I3 = 0,
  AWESOME,
  BSPWM,
  SWAY,
  HYPRLAND,
  RIVER
} WINDOWMANAGER;

// Distro
typedef enum DISTRO { DEBIAN = 0, FEDORA, ARCH, UNKNOWN } DISTRO;

// Type of transfer
typedef enum TRANSFER { NOTHING = 0, LINK, COPY } TRANSFER;

// Config
typedef struct setup_config {
  DISPLAYSERVER display_manager;
  WINDOWMANAGER window_manager;
  DISTRO distro;
  TRANSFER file_transfer;
} config;
