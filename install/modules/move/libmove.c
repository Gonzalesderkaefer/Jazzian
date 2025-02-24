// Other files
#include "libmove.h"



int move_cfg(TRANSFER mode_of_transfer) {
  // Define config src directory
  int cfg_src_len = strlen(getenv("HOME")) + strlen("/Jazzian/cfg_files") + 1;
  char cfg_src[cfg_src_len];
  sprintf(cfg_src,"%s/Jazzian/cfg_files", getenv("HOME"));


  // Define script directory
  int binsrc_len = strlen(getenv("HOME")) + strlen("/Jazzian/bin") + 1;
  char binsrc[binsrc_len];
  sprintf(binsrc,"%s/Jazzian/bin", getenv("HOME"));


  // Define script directory
  int shell_len = strlen(getenv("HOME")) + strlen("/Jazzian/cfg_files/shell") + 1;
  char shellsrc[shell_len];
  sprintf(shellsrc,"%s/Jazzian/cfg_files/shell", getenv("HOME"));


  // Define config dest directory
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_dest_len];
  sprintf(cfg_dest,"%s/.config", getenv("HOME"));


  // Define local dest directory
  int local_len = strlen(getenv("HOME")) + strlen("/.local") + 1;
  char local[local_len];
  sprintf(local,"%s/.local", getenv("HOME"));


  // Define local_bin dest directory
  int localbin_len = strlen(getenv("HOME")) + strlen("/.local/bin") + 1;
  char localbin[localbin_len];
  sprintf(localbin,"%s/.local/bin", getenv("HOME"));


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
