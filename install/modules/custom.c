#include "../def.h"
#include "../utils/file_utils.c"


char *devicespecific_sh =
  "killshells() {\n"
  "    pkill -KILL -u $USER -t tty1\n"
  "}\n"
  "export WM=i3\n"
  "[ \"$(tty)\" = \"/dev/tty1\" ] && (startx; killshells)\n";

char *debmdmenu = 
  "#!/usr/bin/sh\n"
  "if [ $XDG_SESSION_TYPE = \"wayland\" ]; then\n"
  "    wofi_dmenu;\n"
  "else\n"
  "    rofi_dmenu;\n"
  "fi\n";

char *debmdrun = 
  "#!/usr/bin/sh\n"
  "if [ $XDG_SESSION_TYPE = \"wayland\" ]; then\n"
  "    wofi_app;\n"
  "else\n"
  "    rofi_app;\n"
  "fi\n";

char *mdmenu =
  "#!/usr/bin/sh\n"
  "rofi_dmenu\n";

char *mdrun =
  "#!/usr/bin/sh\n"
  "rofi_app\n";

void devicespecific_cfg() {
  // Define config dest directory
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_dest_len];
  strcpy(cfg_dest,getenv("HOME"));
  strcat(cfg_dest,"/.config");

  char *wm[] = {
    "i3",
    "bspwm",
    "awesome",
    "hypr",
    "sway",
    "river",
    NULL
  };

  for (int i = 0; wm[i] != NULL; ++i) {
    int devspc_len = cfg_dest_len + strlen(wm[i]) + strlen("devicespecific") + 3;
    char devspc[devspc_len];
    strcpy(devspc, cfg_dest);
    strcat(devspc, "/");
    strcat(devspc, wm[i]);
    strcat(devspc, "/");
    strcat(devspc, "devicespecific");
    printf("Created Directory: %s\n", devspc);

    if (strcmp(wm[i], "awesome") == 0) {
      // Create cfg file for awesome
      int cfg_len = devspc_len + strlen("devicespecific.lua") + 2;
      char cfg[cfg_len];
      strcpy(cfg, devspc);
      strcat(cfg, "/");
      strcat(cfg, "devicespecific.lua");
      printf("Created file: %s\n", cfg);
      continue;
    }
    // Create cfg file
    int cfg_len = devspc_len + strlen("devicespecific") + 2;
    char cfg[cfg_len];
    strcpy(cfg, devspc);
    strcat(cfg, "/");
    strcat(cfg, "devicespecific");
    printf("Created file: %s\n", cfg);
  }

  // .zprofile eqivalent
  int dev_sh_len = strlen(getenv("HOME")) + strlen(".devicespecific.sh") + 2;
  char dev_sh_path[dev_sh_len];
  sprintf(dev_sh_path, "%s/.devicespecific.sh", getenv("HOME"));



}

int main() {
  devicespecific_cfg();
}
