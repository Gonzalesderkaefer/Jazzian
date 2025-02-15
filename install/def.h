// Libraries
#include <dirent.h>
#include <errno.h>
#include <regex.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>





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
