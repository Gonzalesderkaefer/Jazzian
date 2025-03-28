/* Other files */
#include "include/utils/file_utils.h"
#include <sys/types.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <dirent.h>
#include <stdbool.h>
#include <errno.h>

int mkdir_r(char const *pathname, mode_t mode) {
    /* Copy String to array */
    char path[strlen(pathname) + 1];
    strcpy(path,pathname);


    /* tokenize */
    char *curPath = (char *)calloc(strlen("/") + 1, sizeof(char));
    strcpy(curPath, "/");

    char *token , *rest;
    rest = path;
    while ((token = strtok_r(rest, "/", &rest))) {
        curPath = (char *)realloc(curPath, strlen(curPath) + strlen(token) + 2);
        strcat(curPath, token);
        strcat(curPath, "/");
        mkdir(curPath, mode);
    }

    free(curPath);
    return 0;
}



void copy_file(char *src_file, char *dest_file, mode_t mode) {
  /* Open source file for reading */
  FILE *srcfp = fopen(src_file, "r");
  fseek(srcfp, 0, SEEK_END);

  /* Get size */
  int file_size = ftell(srcfp);
  fseek(srcfp, 0, SEEK_SET);

  /* Data buffer */
  char data[file_size + 3];

  /* Read data into buffer */
  fread(data, sizeof(char), file_size, srcfp);

  /* Open file for writing */
  FILE *destfp = fopen(dest_file, "w");
  fwrite(data, sizeof(char), file_size, destfp);

  fclose(srcfp);
  chmod(dest_file, mode);
}

void write_to_file(char *data, int length, const char *file_path,
                   const char *modes, mode_t mode) {
  /* Open file for writing */
  FILE *file = fopen(file_path, modes);

  /* Write into the file */
  fwrite(data, sizeof(char), length, file);

  /* Close file */
  fclose(file);

  /* Change file permissions */
  chmod(file_path, mode);
}

int copy_dir(char *src_dir, char *dest_parent, char **ill_cfg, bool hide) {
  DIR *directory = opendir(src_dir);
  struct dirent *cfg_content;
  while ((cfg_content = readdir(directory)) != NULL) {
    bool skip = false;
    /* Check if dir name is in ill_cfg */
    for (int i = 0; ill_cfg[i] != NULL; ++i) {
      if (!strcmp(ill_cfg[i], cfg_content->d_name)) {
        skip = true;
        break;
      }
    }
    if (skip)
      continue;

    /* Define full path of file in directory */
    char src[strlen(src_dir) + strlen(cfg_content->d_name) + 2];
    strcpy(src, src_dir);
    strcat(src, "/");
    strcat(src, cfg_content->d_name);

    /* Define full path of dest file */
    char dest[strlen(dest_parent) + strlen(cfg_content->d_name) + 3];
    if (hide) {
      strcpy(dest, dest_parent);
      strcat(dest, "/.");
      strcat(dest, cfg_content->d_name);
    } else {
      strcpy(dest, dest_parent);
      strcat(dest, "/");
      strcat(dest, cfg_content->d_name);
    }

    /* Get Stat of src file */
    struct stat src_stat;
    lstat(src, &src_stat);

    /* Get Stat for dest file */
    struct stat dest_stat;
    lstat(dest, &dest_stat);

    /* Check if destination file exists */
    if (file_exists(dest)) {
      printf("%s exists already\n", dest);
      printf("going to remove %s \n", dest);
      if (S_ISLNK(dest_stat.st_mode) || S_ISREG(dest_stat.st_mode)) {
        unlink(dest);
      } else if (S_ISDIR(dest_stat.st_mode)) {
        rm_dir(dest);
      } else {
        printf("File type unexpected. Not doing anything\n");
        continue;
      }
    }

    /* Check whether file is directory */
    if (S_ISDIR(src_stat.st_mode)) {
      mkdir(dest, src_stat.st_mode);
      printf("Created new Dir in %s with mode %d\n", dest, src_stat.st_mode);
      if (access(src, R_OK) == -1)
        printf("NO ACCESS");
      copy_dir(src, dest, ill_cfg, false);
    } else {
      printf("Copy %s to %s\n", src, dest);
      if (access(src, R_OK) == -1)
        printf("NO ACCESS");
      copy_file(src, dest, src_stat.st_mode);
    }
  }
  closedir(directory);
  return 0;
}

int link_dir(char *src_dir, char *dest_dir, char **ill_cfg, bool hide) {
  DIR *directory = opendir(src_dir);
  struct dirent *cfg_content;
  while ((cfg_content = readdir(directory)) != NULL) {
    bool skip = false;

    /* Check if dir name is in ill_cfg */
    for (int i = 0; ill_cfg[i] != NULL; ++i) {
      if (!strcmp(ill_cfg[i], cfg_content->d_name)) {
        skip = true;
        break;
      }
    }
    if (skip)
      continue;

    unsigned int direlem_len = strlen(cfg_content->d_name);
    unsigned int src_len = strlen(src_dir);
    unsigned int dest_len = strlen(dest_dir);

    /* Define src file path */
    char src[src_len + 1 + direlem_len + 1];
    strcpy(src, src_dir);
    strcat(src, "/");
    strcat(src, cfg_content->d_name);
    src[src_len + 1 + direlem_len] = '\0';

    char dest[dest_len + 2 + direlem_len + 1];
    if (hide) {
      /* Define dest hidden file path */
      strcpy(dest, dest_dir);
      strcat(dest, "/.");
      strcat(dest, cfg_content->d_name);
      printf("linking %s to %s\n", src, dest);
    } else {
      /* Define dest file path */
      strcpy(dest, dest_dir);
      strcat(dest, "/");
      strcat(dest, cfg_content->d_name);
      printf("linking %s to %s\n", src, dest);
    }

    /* Get Stat for dest file */
    struct stat dest_stat;
    lstat(dest, &dest_stat);

    /* Check if destination file exists */
    if (file_exists(dest)) {
      printf("%s exists already\n", dest);
      printf("going to remove %s \n", dest);
      if (S_ISLNK(dest_stat.st_mode) || S_ISREG(dest_stat.st_mode)) {
        unlink(dest);
      } else if (S_ISDIR(dest_stat.st_mode)) {
        rm_dir(dest);
      } else {
        printf("File type unexpected. Not doing anything\n");
        continue;
      }
    }
    symlink(src, dest);
  }
  closedir(directory);
  return 0;
}

int rmfile(const char *fpath, const struct stat *s, int typeflag,
           struct FTW *ftwbuf) {
  struct stat statbuf;
  lstat(fpath, &statbuf);
  if (S_ISLNK(statbuf.st_mode) || S_ISREG(statbuf.st_mode)) {
    unlink(fpath);
  } else if (S_ISDIR(statbuf.st_mode)) {
    rmdir(fpath);
  }

  return 0;
}

int rm_dir(char *path) {
  nftw(path, rmfile, 10, 0);
  nftw(path, rmfile, 10, 0);
  rmdir(path);
  return 0;
}




static int _copy_dir_r(char *src_dir, char const *dest_dir) {
    DIR *directory = opendir(src_dir);
    struct dirent *dircontent;
    while ((dircontent = readdir(directory)) != NULL) {
        /* Don't include ".." and "." */
        if (!(strcmp(dircontent->d_name, "..") && strcmp(dircontent->d_name, ".")))
            continue;

        /* Build src */
        uint32_t src_len = strlen(src_dir) + 1 + strlen(dircontent->d_name) + 1;
        char src[src_len];
        sprintf(src, "%s/%s", src_dir, dircontent->d_name);

        /* Build dest */
        uint32_t dest_len = strlen(dest_dir) + 1 + strlen(dircontent->d_name) + 1;
        char dest[dest_len];
        sprintf(dest, "%s/%s", dest_dir, dircontent->d_name);


        /* if dest already exists, skip */
        if (file_exists(dest)) continue;



        /* Determine type of src */
        struct stat src_stat;
        lstat(src, &src_stat);

        if (S_ISDIR(src_stat.st_mode)) {
            if (access(src, R_OK) == -1) continue; /* If we can't access don't do anything */
            puts("Creating new dir in dest");
            mkdir(dest, src_stat.st_mode);
            _copy_dir_r(src,dest);
        } else {
            if (access(src, R_OK) == -1) continue; /* If we can't access don't do anything */
            printf("%s to %s\n", src, dest);
            copy_file(src, dest, src_stat.st_mode);
        }
    }

    closedir(directory);
    return 0;
}





int copy_dir_r(char *src_dir, char const *dest_dir) {
    /* Sanity Check */
    if (!src_dir || !dest_dir || *src_dir != '/' || *dest_dir != '/')
        return -1;

    /* Sanitize src_dir */
    char *clean_src;
    char src[strlen(src_dir)];
    /* Check if there's / at the end if so remove it */
    if (src_dir[strlen(src_dir) - 1] == '/'){
        memset(src, '\0', strlen(src_dir));
        strncpy(src, src_dir, strlen(src_dir) - 1);
        clean_src = src;
    } else {
        clean_src = src_dir;
    }

    /* Check if src is directory */
    struct stat srcst;
    lstat(clean_src, &srcst);
    if (!S_ISDIR(srcst.st_mode) || !file_exists(clean_src))
        return -1;

    /* This will hold the actual dest base dir */
    char *actual_dest = (char *)dest_dir;
    /* Check if dest_dir is a parent */
    if (dest_dir[strlen(dest_dir) - 1] == '/') {
        /* Get dir name */
        char src[strlen(clean_src)]; /* Otherwise strtok_r will SEGV */
        strcpy(src, clean_src);
        char *rest, *token, *pretok;
        rest = src;
        while((token = strtok_r(rest, "/", &rest)))
            pretok = token;

        char *new_dest =(char *)calloc(strlen(dest_dir) + strlen(pretok) + 1, sizeof(char));
        sprintf(new_dest, "%s%s", dest_dir, pretok);
        actual_dest = new_dest;

        /* Check if new dest exists */
        if (file_exists(new_dest)) {
            free(new_dest);
            return -1;
        }
    } else if (file_exists(dest_dir)) {
        /* Check if new dest exists */ 
        return -1;
    }
    mkdir(actual_dest, srcst.st_mode);





    int cpystat = _copy_dir_r(clean_src, actual_dest);

    if (actual_dest != dest_dir)
        free(actual_dest);

    return cpystat;
}


