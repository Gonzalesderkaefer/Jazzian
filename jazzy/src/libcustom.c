#include "include/libcustom.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h> /* Predifined file contents */
char *devicespecific_sh = "killshells() {\n"
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

char *startx_content = "exec x11startup &\nexec i3\n";

char *x11startup = "#!/usr/bin/bash\n";


static int edit_files(config *system);
static int set_theme();

void devicespecific_cfg(config *system) {
  /* Define config dest directory */
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_dest_len];
  strcpy(cfg_dest, getenv("HOME"));
  strcat(cfg_dest, "/.config");

  char *wm[] = {"i3", "bspwm", "awesome", "hypr", "sway", "river", "vim", NULL};

  for (int i = 0; wm[i] != NULL; ++i) {
    int devspc_len =
        cfg_dest_len + strlen(wm[i]) + strlen("devicespecific") + 3;
    char devspc[devspc_len];
    sprintf(devspc, "%s/%s/devicespecific", cfg_dest, wm[i]);
    printf("Created Directory: %s\n", devspc);
    mkdir(devspc, 0755);

    if (strcmp(wm[i], "awesome") == 0) {
      /* Create cfg file for awesome */
      int cfg_len = devspc_len + strlen("devicespecific.lua") + 2;
      char cfg[cfg_len];
      sprintf(cfg, "%s/devicespecific.lua", devspc);
      printf("Created file: %s\n", cfg);
      write_to_file("", 0,cfg , "a+", 0644);
      continue;
    }
    /* Create cfg file */
    int cfg_len = devspc_len + strlen("devicespecific") + 2;
    char cfg[cfg_len];
    sprintf(cfg, "%s/devicespecific", devspc);
    printf("Created file: %s\n", cfg);
    write_to_file("", 0,cfg , "a+", 0644);
  }

  /* .zprofile eqivalent */
  int dev_sh_len = strlen(getenv("HOME")) + strlen(".devicespecific.sh") + 2;
  char dev_sh_path[dev_sh_len];
  sprintf(dev_sh_path, "%s/.devicespecific.sh", getenv("HOME"));
  if (!file_exists(dev_sh_path))
    write_to_file(devicespecific_sh, strlen(devicespecific_sh), dev_sh_path,
                  "w", 0777);

  /* .zshrc eqivalent */
  int sh_len = strlen(getenv("HOME")) + strlen(".devicerc") + 2;
  char sh_path[sh_len];
  sprintf(sh_path, "%s/.devicerc", getenv("HOME"));
  if (!file_exists(sh_path))
    write_to_file("", strlen(""), sh_path, "w", 0777);

  /* myterm */
  int myterm_len = strlen(getenv("HOME")) + strlen(".local/bin/myterm") + 2;
  char myterm[myterm_len];
  sprintf(myterm, "%s/.local/bin/myterm", getenv("HOME"));
  if (!file_exists(myterm))
    write_to_file(myterm_content, strlen(myterm_content), myterm, "w", 0777);

  /* mdrun */
  int mdrunlen = strlen(getenv("HOME")) + strlen(".local/bin/mdrun") + 2;
  char mdrun[mdrunlen];
  sprintf(mdrun, "%s/.local/bin/mdrun", getenv("HOME"));

  int mdmenulen = strlen(getenv("HOME")) + strlen(".local/bin/mdmenu") + 2;
  char mdmenu[mdmenulen];
  sprintf(mdmenu, "%s/.local/bin/mdmenu", getenv("HOME"));

  /* xinitrc */
  int xinitlen = strlen(getenv("HOME")) + strlen(".xinitrc") + 2;
  char xinit[xinitlen];
  sprintf(xinit, "%s/.xinitrc", getenv("HOME"));
  if (!file_exists(xinit))
    write_to_file(startx_content, strlen(startx_content), xinit, "w", 0644);

  /* x11startup */
  int x11start_len = strlen(getenv("HOME")) + strlen(".local/bin/x11startup") + 2;
  char x11start[x11start_len];
  sprintf(x11start, "%s/.local/bin/x11startup", getenv("HOME"));
  if (!file_exists(x11start))
    write_to_file(x11start, strlen(x11startup), x11start, "w", 0755);


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
  /* Deterimine new window manager */
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
    /* xinitrc filename */
    int xinitlen = strlen(getenv("HOME")) + strlen(".xinitrc") + 2;
    char xinit[xinitlen];
    sprintf(xinit, "%s/.xinitrc", getenv("HOME"));

    /* Open file */
    FILE *startx = fopen(xinit, "r");

    /* Determine size */
    fseek(startx, 0, SEEK_END);
    size_t startx_buf_size = ftell(startx);
    fseek(startx, 0, SEEK_SET); /* Have to reset position */

    /* Read file */
    char startx_buf[startx_buf_size + 1];
    memset(startx_buf, '\0', startx_buf_size + 1);
    fread(startx_buf, sizeof(char), startx_buf_size, startx);
    fclose(startx);

    /* Substitute */
    char *newstartx_buf = search_replace(startx_buf, "exec i3|exec awesome|exec bspwm", windowmanager);
    if(!newstartx_buf) return -1;

    /* Open file for writing */
    startx = fopen(xinit, "w");
    fwrite(newstartx_buf, sizeof(char), strlen(newstartx_buf), startx);
    fclose(startx);

    windowmanager = "&& (startx;";

    /* free new substition */
    free(newstartx_buf);
  }

  /* devicespecific filename */
  int devspclen = strlen(getenv("HOME")) + strlen(".devicespecific.sh") + 2;
  char devspc[devspclen];
  sprintf(devspc, "%s/.devicespecific.sh", getenv("HOME"));

  /* Open file */
  FILE *device = fopen(devspc, "r");

  /* Determine size */
  fseek(device, 0, SEEK_END);
  size_t device_buf_size = ftell(device);
  fseek(device, 0, SEEK_SET);


  /* Read from file */
  char device_buf[device_buf_size + 1];
  memset(device_buf, '\0', device_buf_size + 1);
  fread(device_buf, sizeof(char), device_buf_size, device);
  fclose(device);

  /* Substitute */
  char *newdevice_buf = search_replace(device_buf, "&& \\(.*;", windowmanager); /* Has to be freed!! */

  /* Reopen for writing */
  device = fopen(devspc, "w");
  fwrite(newdevice_buf, sizeof(char), strlen(newdevice_buf), device);
  fclose(device);

  free(newdevice_buf);

  set_theme();
  return 0;
}




int set_theme() {

  char *themecmd[] = { 
    "gsettings",
    "set",
    "org.gnome.desktop.interface",
    "gtk-theme",
    "\'Arc-Dark\'",
    NULL
  };

  char *fontcmd[] = { 
    "gsettings",
    "set",
    "org.gnome.desktop.interface",
    "font-name",
    "\'Jetbrains Mono\'",
    NULL
  };
  
  char *iconcmd[] = { 
    "gsettings",
    "set",
    "org.gnome.desktop.interface",
    "icon-theme",
    "\'Papirus-Dark\'",
    NULL
  };


  pid_t pidtheme = fork();

  switch (pidtheme) {
  case 0:
    execvp("gsettings", (char **)themecmd);
    break;
  case -1:
    fprintf(stderr, "fork failed\n");
    return -1;
    break;
  default:
    wait(NULL);
    break;
  }

  pid_t pidicon = fork();

  switch (pidicon) {
  case 0:
    execvp("gsettings", (char **)iconcmd);
    break;
  case -1:
    fprintf(stderr, "fork failed\n");
    return -1;
    break;
  default:
    wait(NULL);
    break;
  }

  pid_t pidfont = fork();

  switch (pidfont) {
  case 0:
    execvp("gsettings", (char **)fontcmd);
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
