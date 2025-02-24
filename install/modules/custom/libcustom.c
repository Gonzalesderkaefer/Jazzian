#include "libcustom.h"


void devicespecific_cfg(config *cfg) {
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
    "vim",
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
  if (!file_exists(dev_sh_path))
    write_to_file(devicespecific_sh, strlen(devicespecific_sh), dev_sh_path, "w", 0777);

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


  switch(cfg->distro) {
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
}
