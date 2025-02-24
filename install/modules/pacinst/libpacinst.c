// Other files
#include "libpacinst.h"

int inst_pac(config *config) {
  // array names
  const char **base;
  const char **dsp_server;
  const char **wm;
  char *inst_cmd[3];

  switch (config->distro) {
    case DEBIAN:
      inst_cmd[0] = "sudo";
      inst_cmd[1] = "apt";
      inst_cmd[2] = "install";
      base = debian_base;

      if (config->display_manager == WAYLAND) {
        dsp_server = debian_wayland;
        switch(config->window_manager) {
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
        switch(config->window_manager) {
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
      base = fedora_base;

      if (config->display_manager == WAYLAND) {
        dsp_server = fedora_wayland;
        switch(config->window_manager) {
          case HYPRLAND:
            wm = fedora_hypr;
            break;
          case SWAY:
            wm = fedora_hypr;
            break;
          case RIVER:
            wm = fedora_hypr;
            break;
          default: 
            wm = fedora_hypr;
            break;
        }
      } else {
        dsp_server = fedora_xorg;
        switch(config->window_manager) {
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
      base = arch_base;
      if (config->display_manager == WAYLAND) {
        dsp_server = arch_wayland;
        switch(config->window_manager) {
          case HYPRLAND:
            wm = arch_hypr;
            break;
          case SWAY:
            wm = arch_hypr;
            break;
          case RIVER:
            wm = arch_hypr;
            break;
          default: 
            wm = arch_hypr;
            break;
        }
      } else {
        dsp_server = arch_xorg;
        switch(config->window_manager) {
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


  const char *full_cmd[lst_len(base) + lst_len(dsp_server) + lst_len(wm) + 4];

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

  full_cmd[glob_i] = NULL;

  for (;full_cmd[i] != NULL; ++i)
    printf("%s\n", full_cmd[i]);

  pid_t pid = fork();

  switch (pid) {
  case 0:
    printf("hello from subproc\n");
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
