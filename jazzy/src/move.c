/* Libraries */
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

/* Other files */
#include "include/move.h"
#include "include/def.h"
#include "include/utils/dict.h"
#include "include/ignored.h"


static int _move_cfg(const char *src_par, const char *dest_par, Dict *ignored, TRANSFER mode_of_transfer, bool hide) {
    DIR *directory = opendir(src_par);
    struct dirent *cfg_content;
    while ((cfg_content = readdir(directory)) != NULL) {
        /* Check if file is supposed to be ignored */
        if (dict_get(ignored, cfg_content->d_name)) continue;

        /* Build src */
        size_t srclen = strlen(src_par) + 1 + strlen(cfg_content->d_name) + 1;
        char src[srclen];
        sprintf(src, "%s/%s", src_par, cfg_content->d_name);


        /* Build dest */
        size_t destlen = strlen(dest_par) + 2 + strlen(cfg_content->d_name) + 1;
        char dest[destlen];
        if(hide)
            sprintf(dest, "%s/.%s", dest_par, cfg_content->d_name);
        else
            sprintf(dest, "%s/%s", dest_par, cfg_content->d_name);


        printf("%s to %s\n", src, dest);

        /* If file exists, skip for now */

        /*
         * TODO: create a backup of of customized files
         *       Then delete them if necessary
         */
        if(file_exists(dest)) {
            continue;
        }


        switch(mode_of_transfer) {
            case NOTHING:
                closedir(directory);
                return 0;
                break;
            case COPY:
                copy_dir_r(src, dest);
                break;
            case LINK:
                if (file_exists(dest))
                    break;
                symlink(src, dest);
                break;
        }
        printf("%s to %s\n", src, dest);
    }
    closedir(directory);



    return 0;
}


static void _local_i_free(void *ptr) {
    ignored_free(ptr);
}


int move_cfg(TRANSFER mode_of_transfer) {
  /* Define config src directory */
  int cfg_src_len = strlen(getenv("HOME")) + strlen("/Jazzian/cfg_files") + 1;
  char cfg_src[cfg_src_len];
  sprintf(cfg_src,"%s/Jazzian/cfg_files", getenv("HOME"));


  /* Define script directory */
  int binsrc_len = strlen(getenv("HOME")) + strlen("/Jazzian/bin") + 1;
  char binsrc[binsrc_len];
  sprintf(binsrc,"%s/Jazzian/bin", getenv("HOME"));


  /* Define script directory */
  int shell_len = strlen(getenv("HOME")) + strlen("/Jazzian/cfg_files/shell") + 1;
  char shellsrc[shell_len];
  sprintf(shellsrc,"%s/Jazzian/cfg_files/shell", getenv("HOME"));


  /* Define config dest directory */
  int cfg_dest_len = strlen(getenv("HOME")) + strlen("/.config") + 1;
  char cfg_dest[cfg_dest_len];
  sprintf(cfg_dest,"%s/.config", getenv("HOME"));


  /* Define local dest directory */
  int local_len = strlen(getenv("HOME")) + strlen("/.local") + 1;
  char local[local_len];
  sprintf(local,"%s/.local", getenv("HOME"));


  /* Define local_bin dest directory */
  int localbin_len = strlen(getenv("HOME")) + strlen("/.local/bin") + 1;
  char localbin[localbin_len];
  sprintf(localbin,"%s/.local/bin", getenv("HOME"));


  /* Define ignored files */
  Ignored *passgen = ignored_init("passgen", NULL, NULL);
  Ignored *shell = ignored_init("shell", NULL, NULL);
  Ignored *qutebrowser = ignored_init("qutebrowser", NULL, NULL);
  Ignored *code = ignored_init("code", NULL, NULL);
  Ignored *powersave = ignored_init("powersave", NULL, NULL);
  Ignored *this = ignored_init(".", NULL, NULL);
  Ignored *parent = ignored_init("..", NULL, NULL);

  /* insert ignored files */
  Dict *ignoredfiles = dict_init();
  dict_insert(ignoredfiles, "passgen", passgen);
  dict_insert(ignoredfiles, "shell", shell);
  dict_insert(ignoredfiles, "qutebrowser", qutebrowser);
  dict_insert(ignoredfiles, "code", code);
  dict_insert(ignoredfiles, "powersave", powersave);
  dict_insert(ignoredfiles, ".", this);
  dict_insert(ignoredfiles, "..", parent);


  /* Free individual Ignored structs */
  dict_action(ignoredfiles, (void (*) (void *))ignored_free);


  /* Move the main config files */
  _move_cfg(cfg_src, cfg_dest, ignoredfiles, mode_of_transfer, false);

  /* Move the scripts */
  _move_cfg(binsrc, localbin, ignoredfiles, mode_of_transfer, false);

  /* Move shell files */
  _move_cfg(shellsrc, getenv("HOME"), ignoredfiles, mode_of_transfer, true);



  /* Free the actual dictionary */
  dict_free(ignoredfiles);

  return 0;
}
