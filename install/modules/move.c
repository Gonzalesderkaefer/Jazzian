// Other files
#include "../def.h"
#include "../utils/file_utils.c"




int move_cfg(TRANSFER mode_of_transfer) {
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

  switch (mode_of_transfer) {
    case LINK:

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

      break;

    case COPY:

      // Copy general files
      copy_dir(cfg_src, cfg_dest, ill_cfg, false);
      putc('\n',stdout);
      putc('\n',stdout);

      // Copy scripts
      copy_dir(binsrc, localbin, ill_cfg, false);
      putc('\n',stdout);
      putc('\n',stdout);

      // Copy shell configs
      copy_dir(shellsrc, getenv("HOME"), ill_cfg, true);
      putc('\n',stdout);
      putc('\n',stdout);

      break;

    default:
      printf("Not Moving anything\n");
  }
  return 0;
}


int main() {
  move_cfg(COPY);
}
