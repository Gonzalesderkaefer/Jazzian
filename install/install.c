/* Libraries */
#include <regex.h>
#include <stdio.h>

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
  FILE *fd = fopen("/etc/os-release", "r");
  if (!fd) {
    fprintf(stderr, "Could not open release file");
    return UNKNOWN;
  }
}

int main() {
  config this_config;
  /* get display manager from user */
  this_config.display_manager = get_display_server();
  /* getchar won't work otherwise */
  int c;
  while ((c = getchar()) != '\n' && c != EOF)
    ;
  /* get window manager */
  this_config.window_manager = get_window_manager(this_config.display_manager);






  regex_t new_regex;
  regmatch_t pmatch;

  regcomp(&new_regex, "Debian|debian|DEBIAN",REG_EXTENDED);
  int result = regexec(&new_regex, "Debain LInux",new_regex.re_nsub, &pmatch, REG_NOTEOL);
  printf("%d\n",result);
  regfree(&new_regex);









}
