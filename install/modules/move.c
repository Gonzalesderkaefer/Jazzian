// Other files
#include "../def.h"




int link_dir(DIR *directory, char *src_dir, char *dest_dir, char **ill_cfg){

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
  char binsrc[cfg_src_len];
  strcpy(binsrc,getenv("HOME"));
  strcat(binsrc,"/Jazzian/bin");

  // Define config dest directory
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_src_len];
  strcpy(cfg_dest,getenv("HOME"));
  strcat(cfg_dest,"/.config");

  // Define local dest directory
  int local_len = strlen(getenv("HOME")) + strlen("/.local") + 1;
  char local[cfg_src_len];
  strcpy(local,getenv("HOME"));
  strcat(local,"/.local");


  // Define local_bin dest directory
  int localbin_len = strlen(getenv("HOME")) + strlen("/.local/bin") + 1;
  char localbin[cfg_src_len];
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




  // Link general config files
  DIR *cfg_files = opendir(cfg_src);
  /*
  struct dirent *cfg_content;
  while ((cfg_content = readdir(cfg_files)) != NULL) {
    // Check if dir name is in ill_cfg
    for(int i = 0; ill_cfg[i] != NULL; ++i){
      if (!strcmp(ill_cfg[i], cfg_content->d_name)) 
        goto contcfg;
    }
    printf("linking %s/%s to %s/%s\n",cfg_src, cfg_content->d_name, cfg_dest, cfg_content->d_name);

  contcfg:
    continue;

  }
  */

  link_dir(cfg_files, cfg_src, cfg_dest, ill_cfg);
  closedir(cfg_files);

  // Link scripts
  DIR *scripts = opendir(binsrc);
  /*
  struct dirent *script;
  while ((script = readdir(scripts)) != NULL) {
    // Check if dir name is in ill_cfg
    for(int i = 0; ill_cfg[i] != NULL; ++i){
      if (!strcmp(ill_cfg[i], script->d_name)) 
        goto contscript;
    }
    printf("linking %s/%s to %s/%s\n",binsrc, script->d_name, localbin, script->d_name);

  contscript:
    continue;
  }
  */
  link_dir(scripts, binsrc, localbin, ill_cfg);
  closedir(scripts);
  return 0;
}







int main() {
  link_cfg();
}
