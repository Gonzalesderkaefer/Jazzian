#include "include/backup.h"
#include "include/utils/file_utils.h"
#include <string.h>

#define HOME getenv("HOME")


int backup_cfgs(char *backup_name) {
  /* Define backup dir */
  int backup_dir_len = strlen(HOME) + 1 + strlen(backup_name);
  char backup_dir[backup_dir_len + 1];
  sprintf(backup_dir, "%s/%s", HOME, backup_name);
  mkdir(backup_dir, 0755);

  /* Copy windowmanager configs */
  char *wm[] = {"i3", "bspwm", "awesome", "hypr", "sway", "river", "vim", NULL};
  char *ill_cfg[] = {".","..",NULL};
  for (int i = 0; wm[i] != NULL; ++i) {
    /* Define source */
    int wmsrc_len = strlen(HOME) + 1 + strlen(".config") + 1 + strlen(wm[i])+ 1 + strlen("devicespecific");
    char wmsrc[wmsrc_len + 1];
    sprintf(wmsrc, "%s/%s/%s/%s",HOME,".config",wm[i],"devicespecific");

    /* Define parent of dest */
    int wmpar_len = backup_dir_len + 1 + strlen(wm[i]);
    char wmpar[wmpar_len + 1];
    sprintf(wmpar, "%s/%s", backup_dir, wm[i]);
    mkdir(wmpar, 0755);

    /* copy dir */
    copy_dir(wmsrc, wmpar, ill_cfg, false);
    printf("Successfully copied %s\n", wm[i]);
  }

  /* x11startup source */
  int x11startlen = strlen(HOME) + 1 + strlen(".local/bin/x11startup");
  char x11start[x11startlen + 1];
  sprintf(x11start, "%s/%s", HOME, ".local/bin/x11startup");
  if(file_exists(x11start)) {
    /* x11startup dest */
    int x11destlen = backup_dir_len + 1 + strlen("x11startup");
    char x11startdest[x11destlen + 1];
    sprintf(x11startdest, "%s/%s", backup_dir, "x11startup");
    copy_file(x11start, x11startdest, 0755);
  }

  /* zshrc source */
  int devrclen = strlen(HOME) + 1 + strlen(".devicerc");
  char devrc[devrclen + 1];
  sprintf(devrc, "%s/%s", HOME, ".devicerc");
  if (file_exists(devrc)) {
    /* zshrc dest */
    int devdestlen = backup_dir_len + 1 + strlen("devicerc");
    char devrcdest[devdestlen + 1];
    sprintf(devrcdest, "%s/%s", backup_dir, "devicerc");
    copy_file(devrc, devrcdest, 0755);
  }

  /* zprofile source */
  int devproflen = strlen(HOME) + 1 + strlen(".devicespecific.sh");
  char devprof[devproflen + 1];
  sprintf(devprof, "%s/%s", HOME, ".devicespecific.sh");
  if (file_exists(devprof)) {
    /* zprofile dest */
    int devdestlen = backup_dir_len + 1 + strlen("devicespecific.sh");
    char devdest[devdestlen + 1];
    sprintf(devdest, "%s/%s", backup_dir, "devicespecific.sh");
    copy_file(devprof, devdest, 0755);
  }
  return 0;
}









int restore_cfgs(char *backup_name) {
  /* Define backup dir */
  int backup_dir_len = strlen(HOME) + 1 + strlen(backup_name);
  char backup_dir[backup_dir_len + 1];
  sprintf(backup_dir, "%s/%s", HOME, backup_name);

  /* Copy windowmanager configs */
  char *wm[] = {"i3", "bspwm", "awesome", "hypr", "sway", "river", "vim", NULL};
  char *ill_cfg[] = {".","..",NULL};
  for (int i = 0; wm[i] != NULL; ++i) {
    /* Define parent of dest dir */
    int wmsrc_len = strlen(HOME) + 1 + strlen(".config") + 1 + strlen(wm[i])+ 1 + strlen("devicespecific");
    char wmsrc[wmsrc_len + 1];
    sprintf(wmsrc, "%s/%s/%s/%s",HOME,".config",wm[i],"devicespecific");
    if (!file_exists(wmsrc)) mkdir(wmsrc, 0755);

    /* Define parent of dest */
    int wmpar_len = backup_dir_len + 1 + strlen(wm[i]);
    char wmpar[wmpar_len + 1];
    sprintf(wmpar, "%s/%s", backup_dir, wm[i]);

    /* copy dir */
    copy_dir(wmpar, wmsrc, ill_cfg, false);
    printf("Successfully copied %s\n", wm[i]);
  }

  /* Source zprofile */
  int zproflen = backup_dir_len + 1 + strlen("devicespecific.sh");
  char zprof[zproflen + 1];
  sprintf(zprof, "%s/%s", backup_dir, "devicespecific.sh");
  if (file_exists(zprof)) {
    /* Dest zprofile */
    int zprofdestlen = strlen(HOME) + 1 + strlen(".devicespecific.sh");
    char zprofdest[zprofdestlen + 1];
    sprintf(zprofdest, "%s/%s", HOME, ".devicespecific.sh");
    copy_file(zprof, zprofdest, 0644);
  }



  /* Source zshrc */
  int devrclen = backup_dir_len + 1 + strlen("devicerc");
  char devrc[devrclen + 1];
  sprintf(devrc, "%s/%s", backup_dir, "devicerc");
  if (file_exists(devrc)) {
    /* Dest zshrc */
    int devdestlen = strlen(HOME) + 1 + strlen(".devicerc");
    char devdest[devdestlen + 1];
    sprintf(devdest, "%s/%s", HOME, ".devicerc");
    copy_file(devrc, devdest, 0644);
  }

  /* Source x11startup */
  int x11startlen = backup_dir_len + 1 + strlen("x11startup");
  char x11start[x11startlen + 1];
  sprintf(x11start, "%s/%s", backup_dir, "x11startup");
  if (file_exists(x11start)) {
    /* Dest x11startup */
    int x11destlen = strlen(HOME) + 1 + strlen(".local/bin/x11startup");
    char x11dest[x11destlen + 1];
    sprintf(x11dest, "%s/%s", HOME, ".local/bin/x11startup");
    copy_file(x11start, x11dest, 0644);
  }



  return 0;
}











