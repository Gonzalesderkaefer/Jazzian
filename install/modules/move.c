// Other files
#include "../def.h"
#include <dirent.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>




int link_dir(char *src_dir, char *dest_dir, char **ill_cfg, bool hide){
  DIR *directory = opendir(src_dir);
  struct dirent *cfg_content;
outside : while ((cfg_content = readdir(directory)) != NULL) {
    // Check if dir name is in ill_cfg
    for(int i = 0; ill_cfg[i] != NULL; ++i){
      if (!strcmp(ill_cfg[i], cfg_content->d_name)) 
        goto outside;
    }

    uint direlem_len = strlen(cfg_content->d_name);
    uint src_len = strlen(src_dir);
    uint dest_len = strlen(dest_dir);

    // Define src file path
    char src[src_len + 1 + direlem_len + 1];
    strcpy(src, src_dir);
    strcat(src, "/");
    strcat(src, cfg_content->d_name);
    src[src_len + 1 + direlem_len] = '\0';


    if (hide) {
      // Define dest hidden file path
      char dest[dest_len + 2 + direlem_len + 1];
      strcpy(dest, dest_dir);
      strcat(dest, "/.");
      strcat(dest, cfg_content->d_name);
      dest[dest_len + 2 + direlem_len] = '\0';
      printf("linking %s to %s\n", src, dest);
      //symlink(src, dest);
    } else {
      // Define dest file path
      char dest[dest_len + 1 + direlem_len + 1];
      strcpy(dest, dest_dir);
      strcat(dest, "/");
      strcat(dest, cfg_content->d_name);
      printf("linking %s to %s\n", src, dest);
      //symlink(src, dest);
    }

  }
  closedir(directory);
  return 0;
}







int link_cfg() {
  // Define config src directory
  int cfg_src_len = strlen(getenv("HOME")) + strlen("/Jazzian/cfg_files") + 1;
  char cfg_src[cfg_src_len];
  strcpy(cfg_src,getenv("HOME"));
  strcat(cfg_src,"/Jazzian/cfg_files");


  // Define script directory
  int binsrc_len = strlen(getenv("HOME")) + strlen("/Jazzian/bin") + 1;
  char binsrc[binsrc_len];
  strcpy(binsrc,getenv("HOME"));
  strcat(binsrc,"/Jazzian/bin");


  // Define script directory
  int shell_len = strlen(getenv("HOME")) + strlen("/Jazzian/cfg_files/shell") + 1;
  char shellsrc[shell_len];
  strcpy(shellsrc,getenv("HOME"));
  strcat(shellsrc,"/Jazzian/cfg_files/shell");


  // Define config dest directory
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_dest_len];
  strcpy(cfg_dest,getenv("HOME"));
  strcat(cfg_dest,"/.config");


  // Define local dest directory
  int local_len = strlen(getenv("HOME")) + strlen("/.local") + 1;
  char local[local_len];
  strcpy(local,getenv("HOME"));
  strcat(local,"/.local");


  // Define local_bin dest directory
  int localbin_len = strlen(getenv("HOME")) + strlen("/.local/bin") + 1;
  char localbin[localbin_len];
  strcpy(localbin,getenv("HOME"));
  strcat(localbin,"/.local/bin");


  // create dest .config dir
  mkdir(cfg_dest, 0777);
  if (errno == EEXIST)
    fprintf(stderr,"%s already exists\n", cfg_dest);

  // create dest .local dir
  mkdir(local, 0777);
  if (errno == EEXIST)
    fprintf(stderr,"%s already exists\n", local);

  // create dest .local dir
  mkdir(localbin, 0777);
  if (errno == EEXIST)
    fprintf(stderr,"%s already exists\n", localbin);

  putc('\n',stdout);
  putc('\n',stdout);

  // Dirs to not move
  char *ill_cfg[] = {
    ".",
    "..",
    "X11",
    "passgen",
    "shell",
    "nvim",
    "qutebrowser",
    "code",
    NULL
  };

  // Link general files
  link_dir(cfg_src, cfg_dest, ill_cfg, false);
  putc('\n',stdout);
  putc('\n',stdout);

  // Link scripts
  link_dir(binsrc, localbin, ill_cfg, false);
  putc('\n',stdout);
  putc('\n',stdout);

  // Link shell configs
  link_dir(shellsrc, getenv("HOME"), ill_cfg, true);
  putc('\n',stdout);
  putc('\n',stdout);







  return 0;
}







int main() {
  link_cfg();
}
