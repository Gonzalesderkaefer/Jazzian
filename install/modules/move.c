// Other files
#include "../def.h"
#include <dirent.h>




int link_dir(char *src_dir, char *dest_dir, char **ill_cfg){
  DIR *directory = opendir(src_dir);
  struct dirent *cfg_content;
  while ((cfg_content = readdir(directory)) != NULL) {
    // Check if dir name is in ill_cfg
    for(int i = 0; ill_cfg[i] != NULL; ++i){
      if (!strcmp(ill_cfg[i], cfg_content->d_name)) 
        goto contcfg;
    }
    printf("linking %s/%s to %s/%s\n",src_dir, cfg_content->d_name, dest_dir, cfg_content->d_name);

  contcfg:
    continue;
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


  // Dirs to not move
  char *ill_cfg[] = {
    ".",
    "..",
    "X11",
    "passgen",
    "shell",
    "nnn_plugins",
    "nvim",
    "vim",
    "qutebrowser",
    "code",
    NULL
  };
  return 0;
}







int main() {
  link_cfg();
}
