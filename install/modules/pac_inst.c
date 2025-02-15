// Other files
#include "../def.h"



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


int main() {
  config machine = {.distro = ARCH, .file_transfer = LINK, .window_manager = HYPRLAND, .display_manager = WAYLAND};
  inst_pac(&machine);
}













int install_packages(config *config) {
  // Filename components
  char *rel_distro;
  char *display_server;
  char *window_manager;
  char *inst_cmd[3];

  switch (config->distro) {
  case DEBIAN:
    rel_distro = "/Jazzian/install/packages/debian/";
    inst_cmd[0] = "sudo";
    inst_cmd[1] = "apt";
    inst_cmd[2] = "install";
    break;
  case FEDORA:
    rel_distro = "/Jazzian/install/packages/fedora/";
    inst_cmd[0] = "sudo";
    inst_cmd[1] = "dnf";
    inst_cmd[2] = "install";
    break;
  case ARCH:
    rel_distro = "/Jazzian/install/packages/arch/";
    inst_cmd[0] = "sudo";
    inst_cmd[1] = "pacman";
    inst_cmd[2] = "-S";
    break;
  case UNKNOWN:
    return -1;
  }
  switch (config->display_manager) {
  case WAYLAND:
    display_server = "wayland/";
    break;
  case XORG:
    display_server = "xorg/";
    break;
  }

  switch (config->window_manager) {
  case I3:
    window_manager = "bspwm.txt";
    break;
  case AWESOME:
    window_manager = "awesome.txt";
    break;
  case BSPWM:
    window_manager = "bspwm.txt";
    break;
  case SWAY:
    window_manager = "sway.txt";
    break;
  case HYPRLAND:
    window_manager = "hypr.txt";
    break;
  case RIVER:
    window_manager = "river.txt";
    break;
  }

  // store the file name sizes
  size_t base_name_len =
      strlen(getenv("HOME")) + strlen(rel_distro) + strlen("base.txt") + 1;
  size_t ds_name_len = strlen(getenv("HOME")) + strlen(rel_distro) +
                       strlen(display_server) + strlen("base.txt") + 1;
  size_t wm_name_len = strlen(getenv("HOME")) + strlen(rel_distro) +
                       strlen(display_server) + strlen(window_manager) + 1;

  // 'allocate' space
  char base_file_name[base_name_len];
  char display_serv_file_name[ds_name_len];
  char wm_file_name[wm_name_len];

  // Overwrite all the space with NUL
  for (int i = 0; i < base_name_len; ++i) {
    base_file_name[i] = '\0';
  }
  for (int i = 0; i < ds_name_len; ++i) {
    display_serv_file_name[i] = '\0';
  }
  for (int i = 0; i < ds_name_len; ++i) {
    wm_file_name[i] = '\0';
  }

  // Build base filename
  strncat(base_file_name, getenv("HOME"), strlen(getenv("HOME")));
  strncat(base_file_name, rel_distro, strlen(rel_distro));
  strcat(base_file_name, "base.txt");

  // Build display server filename
  strncat(display_serv_file_name, getenv("HOME"), strlen(getenv("HOME")));
  strncat(display_serv_file_name, rel_distro, strlen(rel_distro));
  strncat(display_serv_file_name, display_server, strlen(display_server));
  strcat(display_serv_file_name, "base.txt");

  // Build windowmanager filename
  strncat(wm_file_name, getenv("HOME"), strlen(getenv("HOME")));
  strncat(wm_file_name, rel_distro, strlen(rel_distro));
  strncat(wm_file_name, display_server, strlen(display_server));
  strncat(wm_file_name, window_manager, strlen(window_manager));

  // File pointers
  FILE *stdpkg = fopen(base_file_name, "r");
  if (!stdpkg) {
    fprintf(stderr, "Could not open base packages\n");
    return -1;
  }
  FILE *dsppkg = fopen(display_serv_file_name, "r");
  if (!dsppkg) {
    fprintf(stderr, "Could not open displayserver packages\n");
    return -1;
  }
  FILE *wmpkg = fopen(wm_file_name, "r");
  if (!wmpkg) {
    fprintf(stderr, "Could not open windowmanager packages\n");
    return -1;
  }

  // Determine sizes
  fseek(stdpkg, 0, SEEK_END);
  int std_strlen = ftell(stdpkg) + 2; // 2 cuz space has to be at end
  fseek(stdpkg, 0, SEEK_SET);         // Reset file pointer

  fseek(dsppkg, 0, SEEK_END);
  int dsp_strlen = ftell(dsppkg) + 2; // 2 cuz space has to be at end
  fseek(dsppkg, 0, SEEK_SET);         // Reset file pointer

  fseek(wmpkg, 0, SEEK_END);
  int wm_strlen = ftell(wmpkg) + 2; // 2 cuz space has to be at end
  fseek(wmpkg, 0, SEEK_SET);        // Reset file pointer

  // Create Buffers
  char stdpkg_string[std_strlen];
  char curr;
  for (int i = 0; i < std_strlen; ++i) {
    stdpkg_string[i] = '\0';
  }
  for (int i = 0; (curr = fgetc(stdpkg)) != EOF; ++i) {
    stdpkg_string[i] = curr;
  }

  char dsppkg_string[dsp_strlen];
  for (int i = 0; i < dsp_strlen; ++i) {
    dsppkg_string[i] = '\0';
  }
  for (int i = 0; (curr = fgetc(dsppkg)) != EOF; ++i) {
    dsppkg_string[i] = curr;
  }

  char wmpkg_string[wm_strlen];
  for (int i = 0; i < wm_strlen; ++i) {
    wmpkg_string[i] = '\0';
  }
  for (int i = 0; (curr = fgetc(wmpkg)) != EOF; ++i) {
    wmpkg_string[i] = curr;
  }

  fclose(stdpkg);
  fclose(dsppkg);
  fclose(wmpkg);

  // Tokenize
  char delim[] = " "; // delimitter

  // Tokenize std packages
  char *stdtoken = strtok(stdpkg_string, delim);
  char **stdtokens = malloc(sizeof(char *));
  stdtokens[0] = stdtoken;
  int stdtok_count = 1;
  while ((stdtoken = strtok(NULL, delim)) != NULL) {
    stdtokens = realloc(stdtokens, sizeof(char *) * (stdtok_count + 1));
    if (stdtokens == NULL) {
      fprintf(stderr, "Reallocation Error\n");
      return -1;
    }
    stdtokens[stdtok_count++] = stdtoken;
  }

  // Tokenize displayserver packages
  char *dsptoken = strtok(dsppkg_string, delim);
  char **dsptokens = malloc(sizeof(char *));
  dsptokens[0] = dsptoken;
  int dsptok_count = 1;
  while ((dsptoken = strtok(NULL, delim)) != NULL) {
    dsptokens = realloc(dsptokens, sizeof(char *) * (dsptok_count + 1));
    if (dsptokens == NULL) {
      fprintf(stderr, "Reallocation Error\n");
      return -1;
    }
    dsptokens[dsptok_count++] = dsptoken;
  }

  // Tokenize wm packages
  char *wmtoken = strtok(wmpkg_string, delim);
  char **wmtokens = malloc(sizeof(char *));
  wmtokens[0] = wmtoken;
  int wmtok_count = 1;
  while ((wmtoken = strtok(NULL, delim)) != NULL) {
    wmtokens = realloc(wmtokens, sizeof(char *) * (wmtok_count + 1));
    if (wmtokens == NULL) {
      fprintf(stderr, "Reallocation Error\n");
      return -1;
    }
    wmtokens[wmtok_count++] = wmtoken;
  }

  char *args[wmtok_count + dsptok_count + stdtok_count + 3 + 20];
  int i = 0;
  for (; i < 3; ++i) {
    args[i] = inst_cmd[i];
  }
  for (; i < 3 + stdtok_count; ++i) {
    args[i] = stdtokens[i - 3];
    ulong size = strlen(args[i]);
    args[i][size - 1] = args[i][size - 1] == '\n' ? '\0' : args[i][size - 1];
  }
  for (; i < 3 + stdtok_count + dsptok_count; ++i) {
    args[i] = dsptokens[i - 3 - stdtok_count];
    ulong size = strlen(args[i]);
    args[i][size - 1] = args[i][size - 1] == '\n' ? '\0' : args[i][size - 1];
  }
  for (; i < 3 + stdtok_count + dsptok_count + wmtok_count; ++i) {
    args[i] = wmtokens[i - 3 - stdtok_count - dsptok_count];
    ulong size = strlen(args[i]);
    args[i][size - 1] = args[i][size - 1] == '\n' ? '\0' : args[i][size - 1];
  }
  /*
   */

  free(wmtokens);
  free(dsptokens);
  free(stdtokens);

  for (int j = 0; j < i; ++j) {
    printf("%s, length: %lu\n", args[j], strlen(args[j]));
  }

  pid_t pid = fork();

  switch (pid) {
  case 0:
    printf("hello from subproc\n");
    execvp("sudo", args);
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
