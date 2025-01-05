/* Libraries */
#include <regex.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdbool.h>

/* Other files */
#include "vars.h"



enum DISPLAYSERVER get_display_server() {
  /* Ask user */
  printf("\033[1;35mChoose a Displayserver\033[0m\n");
  printf("\033[0;32m[x]org (default)\033[0m\n");
  printf("\033[0;32m[w]ayland \033[0m\n");
  printf("Your Choice: ");
  /* Get users choice */
  char choice = getchar();

  if (choice == 'w' || choice == 'W')
    return WAYLAND;

  return XORG;
}

enum WINDOWMANAGER get_window_manager(enum DISPLAYSERVER display_server) {
  /* Ask user */
  printf("\033[1;35mChoose a Windowmanager\033[0m\n");
  char choice;
  switch (display_server) {
  case XORG:
    printf("\033[0;32m[i]3 (default)\033[0m\n");
    printf("\033[0;32m[a]wesome \033[0m\n");
    printf("\033[0;32m[b]spwm \033[0m\n");
    printf("Your Choice: ");

    /* Get users choice */
    choice = getchar();

    /* Check user choice and return */
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

    /* Get users choice */
    choice = getchar();

    /* Check user choice and return */
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
  /* Determine size of file */
  fseek(file, 0,SEEK_END);
  int length = ftell(file);
  /* Set file pointer to the beginning */
  fseek(file,0,SEEK_SET);

  /* Read the file */
  char release[length + 1];
  int i = 0;
  char curr;
  while ((curr = fgetc(file)) != EOF){
    release[i] = curr;
    ++i;
  }

  fclose(file);


  /* Constructing regexes */
  regex_t arch;
  regmatch_t arch_pmatch[5];
  regex_t debian;
  regmatch_t debian_pmatch[5];
  regex_t fedora;
  regmatch_t fedora_pmatch[5];

  regcomp(&arch, "ARCH LINUX|Arch Linux|arch linux", REG_EXTENDED);
  regcomp(&debian, "DEBIAN|Debian|debian", REG_EXTENDED);
  regcomp(&fedora, "FEDORA|Fedora|fedora", REG_EXTENDED);

  int archStat = regexec(&arch,release,arch.re_nsub+1,arch_pmatch,REG_NOTEOL);
  int debStat = regexec(&debian,release,debian.re_nsub+1,arch_pmatch,REG_NOTEOL);
  int fedStat = regexec(&fedora,release,fedora.re_nsub+1,fedora_pmatch,REG_NOTEOL);

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
  /* Ask user */
  printf("\033[1;35mChoose method of transfer\033[0m\n");
  printf("\033[0;32mDo [N]othing (default)\033[0m\n");
  printf("\033[0;32m[l]ink \033[0m\n");
  printf("\033[0;32m[c]opy \033[0m\n");
  printf("Your Choice: ");
  /* Get users choice */
  char choice = getchar();
  /* Check user choice and return */
  if (choice == 'l' || choice == 'L') {
    return LINK;
  } else if (choice == 'c' || choice == 'C') {
    return COPY;
  } else {
    return NOTHING;
  }

}


config *get_config() {
  /* Buff char for flushing */
  int c;
  /* Config struct */
  static config this_config;
  /* get display manager from user */
  this_config.display_manager = get_display_server();
  /* getchar won't work otherwise */
  while ((c = getchar()) != '\n' && c != EOF);
  /* get window manager */
  this_config.window_manager = get_window_manager(this_config.display_manager);
  /* getchar won't work otherwise */
  while ((c = getchar()) != '\n' && c != EOF);
  /* Get Distro */
  this_config.distro = get_distro();
  /* Get Transfer type */
  this_config.file_transfer = get_transfer();
  while ((c = getchar()) != '\n' && c != EOF);
  return &this_config;
}


int install_packages(config *config) {
  // File pointers
  /*
  FILE *stdpkg;
  FILE *displservpkg;
  FILE *wmpkg;
  */

  // Filename components
  char *rel_distro;
  char *display_server;
  char *window_manager;

  switch (config->distro) {
    case DEBIAN:
      rel_distro = "/Jazzian/install/packages/debian/";
      break;
    case FEDORA:
      rel_distro = "/Jazzian/install/packages/fedora/";
      break;
    case ARCH:
      rel_distro = "/Jazzian/install/packages/arch/";
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
  size_t base_name_len = strlen(getenv("HOME")) + strlen(rel_distro) + strlen("base.txt") + 1;
  size_t ds_name_len = strlen(getenv("HOME")) + strlen(rel_distro) + strlen(display_server) + strlen("base.txt") + 1;
  size_t wm_name_len = strlen(getenv("HOME")) + strlen(rel_distro) + strlen(display_server) + strlen(window_manager) + 1;

  // 'allocate' space
  char base_file_name[base_name_len];
  char display_serv_file_name[ds_name_len];
  char wm_file_name[wm_name_len];

  // Overwrite all the space with NULL
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

  // display server filename
  strncat(display_serv_file_name, getenv("HOME"), strlen(getenv("HOME")));
  strncat(display_serv_file_name, rel_distro, strlen(rel_distro));
  strncat(display_serv_file_name, display_server, strlen(display_server));
  strncat(display_serv_file_name, "base.txt", strlen("base.txt"));


  // windowmanager filename
  strncat(wm_file_name, getenv("HOME"), strlen(getenv("HOME")));
  strncat(wm_file_name, rel_distro, strlen(rel_distro));
  strncat(wm_file_name, display_server, strlen(display_server));
  strncat(wm_file_name, window_manager, strlen(window_manager));

  printf("base file name is: %s\n",base_file_name);
  printf("display server file name is: %s\n",display_serv_file_name);
  printf("window manager file name is: %s\n",wm_file_name);

  /*
  char message[] = "Davey How you doin";
  char delim[] = " ";
  char *token;
  char **saveptr;
  token = strtok(message, delim);
  char **tokens = (char **)malloc(sizeof(char *));
  tokens[0] = token;
  int tok_count = 1;

  while (true) {
    token = strtok(NULL, delim);
    if (token == NULL) {
      break;
    }
    tokens = (char **)realloc(tokens, sizeof(char *) * (tok_count + 1));
    tokens[tok_count] = token;
    tok_count+=1;
  }

  for (int i = 0; i < tok_count; ++i) {
    printf("%s\n",tokens[i]);
  }


  free(tokens);



    pid_t pid = fork();

    switch (pid) {
        case 0:
            printf("hello from subproc\n");
            char *args[] = {"sudo", "dnf install vim"};
            execvp("sudo", args);
            break;
        case -1:
            fprintf(stderr, "fork failed\n");
            return -1;
            break;
        default:
            printf("hello from parent\n");
            char *message = "password\n";
            wait(NULL);
            break;
    }
  */
  return 0;

}






int main() {
  config *mycfg = get_config();
  install_packages(mycfg);


}
