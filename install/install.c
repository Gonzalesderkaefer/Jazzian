// Libraries
#include <errno.h>
#include <regex.h>
#include <dirent.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

// Other files
#include "def.h"

enum DISPLAYSERVER get_display_server() {
  // Ask user
  printf("\033[1;35mChoose a Displayserver\033[0m\n");
  printf("\033[0;32m[x]org (default)\033[0m\n");
  printf("\033[0;32m[w]ayland \033[0m\n");
  printf("Your Choice: ");
  // Get users choice
  char choice = getchar();

  if (choice == 'w' || choice == 'W')
    return WAYLAND;

  return XORG;
}

enum WINDOWMANAGER get_window_manager(enum DISPLAYSERVER display_server) {
  // Ask user
  printf("\033[1;35mChoose a Windowmanager\033[0m\n");
  char choice;
  switch (display_server) {
  case XORG:
    printf("\033[0;32m[i]3 (default)\033[0m\n");
    printf("\033[0;32m[a]wesome \033[0m\n");
    printf("\033[0;32m[b]spwm \033[0m\n");
    printf("Your Choice: ");

    // Get users choice
    choice = getchar();

    // Check user choice and return
    if (choice == 'b' || choice == 'B') {
      return BSPWM;
    } else if (choice == 'a' || choice == 'A') {
      return AWESOME;
    } else {
      return I3;
    }

    break;
  case WAYLAND:
    printf("\033[0;32m[s]way (default)\033[0m\n");
    printf("\033[0;32m[h]yprland \033[0m\n");
    printf("\033[0;32m[r]iver \033[0m\n");
    printf("Your Choice: ");

    // Get users choice
    choice = getchar();

    // Check user choice and return
    if (choice == 'h' || choice == 'H') {
      return HYPRLAND;
    } else if (choice == 'r' || choice == 'R') {
      return RIVER;
    } else {
      return SWAY;
    }

    break;
  }
}

enum DISTRO get_distro() {
  FILE *file = fopen("/etc/os-release", "r");
  if (!file) {
    fprintf(stderr, "Could not open release file");
    return UNKNOWN;
  }
  // Determine size of file
  fseek(file, 0, SEEK_END);
  int length = ftell(file);
  // Set file pointer to the beginning
  fseek(file, 0, SEEK_SET);

  // Read the file
  char release[length + 1];
  int i = 0;
  char curr;
  while ((curr = fgetc(file)) != EOF) {
    release[i] = curr;
    ++i;
  }

  fclose(file);

  // Constructing regexes
  regex_t arch;
  regmatch_t arch_pmatch[5];
  regex_t debian;
  regmatch_t debian_pmatch[5];
  regex_t fedora;
  regmatch_t fedora_pmatch[5];

  regcomp(&arch, "ARCH LINUX|Arch Linux|arch linux", REG_EXTENDED);
  regcomp(&debian, "DEBIAN|Debian|debian", REG_EXTENDED);
  regcomp(&fedora, "FEDORA|Fedora|fedora", REG_EXTENDED);

  int archStat =
      regexec(&arch, release, arch.re_nsub + 1, arch_pmatch, REG_NOTEOL);
  int debStat =
      regexec(&debian, release, debian.re_nsub + 1, arch_pmatch, REG_NOTEOL);
  int fedStat =
      regexec(&fedora, release, fedora.re_nsub + 1, fedora_pmatch, REG_NOTEOL);

  regfree(&arch);
  regfree(&debian);
  regfree(&fedora);

  if (archStat == 0) {
    printf("\033[0;32mFound Arch Linux\033[0m\n");
    return ARCH;
  }
  if (debStat == 0) {
    printf("\033[0;32mFound Debian\033[0m\n");
    return DEBIAN;
  }
  if (fedStat == 0) {
    printf("\033[0;32mFound Fedora\033[0m\n");
    return FEDORA;
  }
  return UNKNOWN;
}

enum TRANSFER get_transfer() {
  // Ask user
  printf("\033[1;35mChoose method of transfer\033[0m\n");
  printf("\033[0;32mDo [N]othing (default)\033[0m\n");
  printf("\033[0;32m[l]ink \033[0m\n");
  printf("\033[0;32m[c]opy \033[0m\n");
  printf("Your Choice: ");
  // Get users choice
  char choice = getchar();
  // Check user choice and return
  if (choice == 'l' || choice == 'L') {
    return LINK;
  } else if (choice == 'c' || choice == 'C') {
    return COPY;
  } else {
    return NOTHING;
  }
}

config *get_config() {
  // Buff char for flushing
  int c;
  /* Config struct */
  static config this_config;
  // get display manager from user
  this_config.display_manager = get_display_server();
  // getchar won't work otherwise
  while ((c = getchar()) != '\n' && c != EOF)
    ;
  // get window manager
  this_config.window_manager = get_window_manager(this_config.display_manager);
  /* getchar won't work otherwise */
  while ((c = getchar()) != '\n' && c != EOF)
    ;
  // Get Distro
  this_config.distro = get_distro();
  // Get Transfer type
  this_config.file_transfer = get_transfer();
  while ((c = getchar()) != '\n' && c != EOF)
    ;
  return &this_config;
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
  strncat(base_file_name, "base.txt", strlen("base.txt"));

  // Build display server filename
  strncat(display_serv_file_name, getenv("HOME"), strlen(getenv("HOME")));
  strncat(display_serv_file_name, rel_distro, strlen(rel_distro));
  strncat(display_serv_file_name, display_server, strlen(display_server));
  strncat(display_serv_file_name, "base.txt", strlen("base.txt"));

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
  for (; i < 3+stdtok_count+dsptok_count; ++i) {
    args[i] = dsptokens[i-3-stdtok_count];
    ulong size = strlen(args[i]);
    args[i][size - 1] = args[i][size - 1] == '\n' ? '\0' : args[i][size - 1];
  }
  for (; i < 3+stdtok_count+dsptok_count+wmtok_count; ++i) {
    args[i] = wmtokens[i-3-stdtok_count-dsptok_count];
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


void link_cfgs() {
  // Get home path
  char *home;
  if (!(home = getenv("HOME"))) return;
  // Build root of config
  char cfg_dir[strlen("/Jazzian/cfg_files/") + strlen(home) + 1];
  for(int i = 0; i < strlen("/Jazzian/cfg_files/") + strlen(home) + 1; ++i) cfg_dir[i] = '\0';
  strcat(cfg_dir, home);
  strcat(cfg_dir, "/Jazzian/cfg_files/");
  printf("%s\n", cfg_dir);

  // Build config paths
  char **cfgs = malloc(sizeof(char *));
  int path_cnt = 1;

  DIR *dir;
  dir = opendir(cfg_dir);
  struct dirent *d;
  while ((d = readdir(dir))) {
    // Build file name



    // Reallocate
    cfgs = realloc(cfgs, sizeof(char *) * (path_cnt + 1));
    if (!cfgs){
      fprintf(stderr, "Reallcoation error\n");
      return;
    }
    path_cnt++;
  }

  for (int i = 0; i < path_cnt-1; ++i) printf("%s\n", cfgs[i]);



  free(cfgs);
}



int main() {
  config conf = {.distro = DEBIAN,
                 .file_transfer = LINK,
                 .window_manager = AWESOME,
                 .display_manager = XORG};
  link_cfgs();
}
