/* header file */
#include "def.h"
#include <stdio.h>




char *dsp_str(enum DISPLAYSERVER dsp){
  switch (dsp) {
    case WAYLAND:
      return "wayland";
    default: 
      return "xorg";
  }
}

char *wm_str(enum WINDOWMANAGER wm){
  switch(wm) {
    case I3:
      return "i3";
    case AWESOME:
      return "awesome";
    case BSPWM:
      return "bspwm";
    case SWAY:
      return "sway";
    case HYPRLAND:
      return "hyprland";
    case RIVER:
      return "river";
    default: 
      return "unknown";
  }
}

char *dist_str(enum DISTRO dist){
  switch (dist) {
    case DEBIAN:
      return "debian";
    case ARCH:
      return "archlinux";
    case FEDORA:
      return "fedora";
    default:
      return "unknown";
  
  }
}

char *tr_str(enum TRANSFER tr){
  switch (tr) {
    case LINK:
      return "link";
    case COPY:
      return "copy";
    default:
      return "nothing";
  }
}



char *cfg_str(config *cfg) {
  static char name[1024];

  char *dsp = dsp_str(cfg->display_manager);
  char *wm = wm_str(cfg->window_manager);
  char *dist = dist_str(cfg->distro);
  char *tr = tr_str(cfg->file_transfer);

  sprintf(name, 
          "{\n\"Displayserver\": \"%s\",\n\"Windowmanager\": \"%s\",\n\"Transfer\": \"%s\",\n\"Distro\": \"%s\"\n}", 
          dsp, wm, tr, dist);

  return name;
}
