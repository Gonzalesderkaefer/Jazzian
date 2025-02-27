#include "../headers/libcustom.h"
#include <stdlib.h>

// Predifined file contents
char *devicespecific_sh =
    "killshells() {\n"
    "    pkill -KILL -u $USER -t tty1\n"
    "}\n"
    "[ \"$(tty)\" = \"/dev/tty1\" ] && (startx; killshells)\n";

char *debmdmenu = "#!/usr/bin/sh\n"
                  "if [ $XDG_SESSION_TYPE = \"wayland\" ]; then\n"
                  "    wofi_dmenu;\n"
                  "else\n"
                  "    rofi_dmenu;\n"
                  "fi\n";

char *debmdrun = "#!/usr/bin/sh\n"
                 "if [ $XDG_SESSION_TYPE = \"wayland\" ]; then\n"
                 "    wofi_app;\n"
                 "else\n"
                 "    rofi_app;\n"
                 "fi\n";

char *mdmenu_content = "#!/usr/bin/sh\n"
                       "rofi_dmenu\n";

char *mdrun_content = "#!/usr/bin/sh\n"
                      "rofi_app\n";

char *myterm_content = "    #!/bin/dash\n"
                       "    case $XDG_SESSION_TYPE in\n"
                       "        \"wayland\")\n"
                       "            alacritty -o font.size=12\n"
                       "            ;;\n"
                       "        *)\n"
                       "            alacritty -o font.size=12\n"
                       "            ;;\n"
                       "    esac\n";

char *startx_content = "exec i3\n";


int edit_files(config *system);

void devicespecific_cfg(config *system) {
  // Define config dest directory
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_dest_len];
  strcpy(cfg_dest, getenv("HOME"));
  strcat(cfg_dest, "/.config");

  char *wm[] = {"i3", "bspwm", "awesome", "hypr", "sway", "river", "vim", NULL};

  for (int i = 0; wm[i] != NULL; ++i) {
    int devspc_len =
        cfg_dest_len + strlen(wm[i]) + strlen("devicespecific") + 3;
    char devspc[devspc_len];
    strcpy(devspc, cfg_dest);
    strcat(devspc, "/");
    strcat(devspc, wm[i]);
    strcat(devspc, "/");
    strcat(devspc, "devicespecific");
    printf("Created Directory: %s\n", devspc);
    mkdir(devspc, 0755);

    if (strcmp(wm[i], "awesome") == 0) {
      // Create cfg file for awesome
      int cfg_len = devspc_len + strlen("devicespecific.lua") + 2;
      char cfg[cfg_len];
      strcpy(cfg, devspc);
      strcat(cfg, "/");
      strcat(cfg, "devicespecific.lua");
      printf("Created file: %s\n", cfg);
      write_to_file("", 0,cfg , "a+", 0644);
      continue;
    }
    // Create cfg file
    int cfg_len = devspc_len + strlen("devicespecific") + 2;
    char cfg[cfg_len];
    strcpy(cfg, devspc);
    strcat(cfg, "/");
    strcat(cfg, "devicespecific");
    printf("Created file: %s\n", cfg);
    write_to_file("", 0,cfg , "a+", 0644);
  }

  // .zprofile eqivalent
  int dev_sh_len = strlen(getenv("HOME")) + strlen(".devicespecific.sh") + 2;
  char dev_sh_path[dev_sh_len];
  sprintf(dev_sh_path, "%s/.devicespecific.sh", getenv("HOME"));
  if (!file_exists(dev_sh_path))
    write_to_file(devicespecific_sh, strlen(devicespecific_sh), dev_sh_path,
                  "w", 0777);

  // .zshrc eqivalent
  int sh_len = strlen(getenv("HOME")) + strlen(".devicerc.sh") + 2;
  char sh_path[sh_len];
  sprintf(sh_path, "%s/.devicerc.sh", getenv("HOME"));
  if (!file_exists(sh_path))
    write_to_file("", strlen(""), sh_path, "w", 0777);

  // myterm
  int myterm_len = strlen(getenv("HOME")) + strlen(".local/bin/myterm") + 2;
  char myterm[myterm_len];
  sprintf(myterm, "%s/.local/bin/myterm", getenv("HOME"));
  if (!file_exists(myterm))
    write_to_file(myterm_content, strlen(myterm_content), myterm, "w", 0777);

  // mdrun
  int mdrunlen = strlen(getenv("HOME")) + strlen(".local/bin/mdrun") + 2;
  char mdrun[mdrunlen];
  sprintf(mdrun, "%s/.local/bin/mdrun", getenv("HOME"));

  int mdmenulen = strlen(getenv("HOME")) + strlen(".local/bin/mdmenu") + 2;
  char mdmenu[mdmenulen];
  sprintf(mdmenu, "%s/.local/bin/mdmenu", getenv("HOME"));

  // xinitrc
  int xinitlen = strlen(getenv("HOME")) + strlen(".xinitrc") + 2;
  char xinit[xinitlen];
  sprintf(xinit, "%s/.xinitrc", getenv("HOME"));
  if (!file_exists(xinit))
    write_to_file(startx_content, strlen(startx_content), xinit, "w", 0644);

  switch (system->distro) {
  case DEBIAN:
    if (!file_exists(mdmenu))
      write_to_file(debmdmenu, strlen(debmdmenu), mdmenu, "w", 0777);
    if (!file_exists(mdrun))
      write_to_file(debmdrun, strlen(debmdrun), mdrun, "w", 0777);
    break;

  default:
    if (!file_exists(mdmenu))
      write_to_file(mdmenu_content, strlen(mdmenu_content), mdmenu, "w", 0777);
    if (!file_exists(mdrun))
      write_to_file(mdrun_content, strlen(mdrun_content), mdrun, "w", 0777);
  }
  edit_files(system);
}

int edit_files(config *system) {
  // Deterimine new window manager
  char *windowmanager;
  bool skip_xinit = false;

  switch (system->window_manager) {
  case AWESOME:
    windowmanager = "exec awesome";
    break;
  case I3:
    windowmanager = "exec i3";
    break;
  case BSPWM:
    windowmanager = "exec bspwm";
    break;
  case SWAY:
    windowmanager = "&& (sway;";
    skip_xinit = true;
    break;
  case RIVER:
    windowmanager = "&& (river;";
    skip_xinit = true;
    break;
  case HYPRLAND:
    windowmanager = "&& (Hyprland;";
    skip_xinit = true;
    break;
  }

  if (!skip_xinit) {
    // xinitrc filename
    int xinitlen = strlen(getenv("HOME")) + strlen(".xinitrc") + 2;
    char xinit[xinitlen];
    sprintf(xinit, "%s/.xinitrc", getenv("HOME"));

    // Open file
    FILE *startx = fopen(xinit, "r");

    // Read from file
    // TODO: Error checking
    char *oldxinit = NULL;
    size_t bufsize = 0;
    if (getdelim(&oldxinit, &bufsize, EOF, startx) == -1) {
      free(oldxinit);
      return -1;
    }

    // Substitute
    char *newxinit = search_replace(oldxinit, "exec i3|exec awesome|exec bspwm",
                                    windowmanager);

    if (newxinit) {
      // Write to file
      write_to_file(newxinit, strlen(newxinit), xinit, "w", 0644);
      free(newxinit);
    }
    windowmanager = "&& (startx;";
    fclose(startx);
  }

  // devicespecific filename
  int devspclen = strlen(getenv("HOME")) + strlen(".devicespecific.sh") + 2;
  char devspc[devspclen];
  sprintf(devspc, "%s/.devicespecific.sh", getenv("HOME"));

  // Open file
  FILE *device = fopen(devspc, "r");

  // Read from file
  char *olddev = NULL;
  size_t bufsize = 0;
  if (getdelim(&olddev, &bufsize, EOF, device) == -1) {
    free(olddev);
    return -1;
  }
  // Substitute
  char *newdev = search_replace(olddev, "&& \\(.*;", windowmanager);

  if (newdev) {
    // Write to file
    write_to_file(newdev, strlen(newdev), devspc, "w", 0644);
    free(newdev);
  }

  fclose(device);
  return 0;
}
