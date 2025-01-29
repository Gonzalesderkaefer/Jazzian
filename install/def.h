typedef enum DISPLAYSERVER { XORG, WAYLAND } DISPLAYSERVER;

typedef enum WINDOWMANAGER {
  I3,
  AWESOME,
  BSPWM,
  SWAY,
  HYPRLAND,
  RIVER
} WINDOWMANAGER;

typedef enum DISTRO { DEBIAN, FEDORA, ARCH, UNKNOWN } DISTRO;

typedef enum TRANSFER { NOTHING, LINK, COPY } TRANSFER;

typedef struct setup_config {
  DISPLAYSERVER display_manager;
  WINDOWMANAGER window_manager;
  DISTRO distro;
  TRANSFER file_transfer;
} config;
