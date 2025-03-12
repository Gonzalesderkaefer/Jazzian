/* Other files */
#include "include/libpacinst.h"
#include <stdio.h>

int inst_pac(config *system) {
  /* array names */
  const char **base;
  const char **dsp_server;
  const char **wm;
  char *inst_cmd[4];

  switch (system->distro) {
    case DEBIAN:
      inst_cmd[0] = "sudo";
      inst_cmd[1] = "apt";
      inst_cmd[2] = "install";
      inst_cmd[3] = "-y";
      base = debian_base;

      if (system->display_manager == WAYLAND) {
        dsp_server = debian_wayland;
        switch(system->window_manager) {
          case HYPRLAND:
            wm = debian_hypr;
            break;
          case SWAY:
            wm = debian_sway;
            break;
          case RIVER:
            wm = debian_river;
            break;
          default: 
            wm = debian_sway;
            break;
        }
      } else {
        dsp_server = debian_xorg;
        switch(system->window_manager) {
          case BSPWM:
            wm = debian_bspwm;
            break;
          case AWESOME:
            wm = debian_awesome;
            break;
          case I3:
            wm = debian_i3;
            break;
          default: 
            wm = debian_i3;
            break;
        }
      }

      break;
    case FEDORA:
      inst_cmd[0] = "sudo";
      inst_cmd[1] = "dnf";
      inst_cmd[2] = "install";
      inst_cmd[3] = "-y";
      base = fedora_base;

      if (system->display_manager == WAYLAND) {
        dsp_server = fedora_wayland;
        switch(system->window_manager) {
          case HYPRLAND:
            wm = fedora_hypr;
            break;
          case SWAY:
            wm = fedora_sway;
            break;
          case RIVER:
            wm = fedora_river;
            break;
          default: 
            wm = fedora_sway;
            break;
        }
      } else {
        dsp_server = fedora_xorg;
        switch(system->window_manager) {
          case BSPWM:
            wm = fedora_bspwm;
            break;
          case AWESOME:
            wm = fedora_awesome;
            break;
          case I3:
            wm = fedora_i3;
            break;
          default: 
            wm = fedora_i3;
            break;
        }
      }



      break;
    case ARCH:
      inst_cmd[0] = "sudo";
      inst_cmd[1] = "pacman";
      inst_cmd[2] = "-S";
      inst_cmd[3] = " ";
      base = arch_base;
      if (system->display_manager == WAYLAND) {
        dsp_server = arch_wayland;
        switch(system->window_manager) {
          case HYPRLAND:
            wm = arch_hypr;
            break;
          case SWAY:
            wm = arch_sway;
            break;
          case RIVER:
            wm = arch_river;
            break;
          default: 
            wm = arch_sway;
            break;
        }
      } else {
        dsp_server = arch_xorg;
        switch(system->window_manager) {
          case BSPWM:
            wm = arch_bspwm;
            break;
          case AWESOME:
            wm = arch_awesome;
            break;
          case I3:
            wm = arch_i3;
            break;
          default: 
            wm = arch_i3;
            break;
        }
      }
      break;
    case UNKNOWN:
      return -1;
  }


  const char *full_cmd[lst_len(base) + lst_len(dsp_server) + lst_len(wm) + 7];

  int glob_i = 0;
  int i = 0;
  for(;i < 3; ++i)
    full_cmd[glob_i++] = inst_cmd[i];
  i = 0;

  for(;base[i] != NULL; ++i)
    full_cmd[glob_i++] = base[i];
  i = 0;

  for(;dsp_server[i] != NULL; ++i)
    full_cmd[glob_i++] = dsp_server[i];
  i = 0;

  for(;wm[i] != NULL; ++i)
    full_cmd[glob_i++] = wm[i];
  i = 0;

  if (system->distro == ARCH) {
    full_cmd[glob_i++] = "--noconfirm";
    full_cmd[glob_i++] = "--needed";
  }

  full_cmd[glob_i] = NULL;

  pid_t pid = fork();

  switch (pid) {
  case 0:
    execvp("sudo", (char **)full_cmd);
    break;
  case -1:
    fprintf(stderr, "fork failed\n");
    return -1;
    break;
  default:
    wait(NULL);
    break;
  }
  return 0;
}



int update(config *system) {
  char *upgrade_cmd[6];

  switch (system->distro) {
    case ARCH:
      upgrade_cmd[0] = "sudo";
      upgrade_cmd[1] = "pacman";
      upgrade_cmd[2] = "-Syu";
      upgrade_cmd[3] = "--noconfirm";
      upgrade_cmd[4] = "--needed";
      upgrade_cmd[5] = NULL;
      break;
    case DEBIAN:
      upgrade_cmd[0] = "sudo";
      upgrade_cmd[1] = "apt";
      upgrade_cmd[2] = "upgrade";
      upgrade_cmd[3] = "-y";
      upgrade_cmd[4] = NULL;
      upgrade_cmd[5] = NULL;
      break;
    case FEDORA:
      upgrade_cmd[0] = "sudo";
      upgrade_cmd[1] = "dnf";
      upgrade_cmd[2] = "update";
      upgrade_cmd[3] = "-y";
      break;
  }


  pid_t pid = fork();
  switch (pid) {
  case 0:
    execvp("sudo", upgrade_cmd);
    break;
  case -1:
    fprintf(stderr, "fork failed\n");
    return -1;
    break;
  default:
    wait(NULL);
    break;
  }
  return 0;
}




