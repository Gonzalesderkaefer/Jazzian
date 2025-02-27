// Other files
#include "../headers/utils/file_utils.h"

void copy_file(char *src_file, char *dest_file, mode_t mode) {
  // Open source file for reading
  FILE *srcfp = fopen(src_file, "r");
  fseek(srcfp,0, SEEK_END);

  // Get size
  int file_size = ftell(srcfp);
  fseek(srcfp,0, SEEK_SET);

  // Data buffer
  char data[file_size + 3];

  // Read data into buffer
  fread(data, sizeof(char), file_size, srcfp);

  // Open file for writing
  FILE *destfp = fopen(dest_file, "w");
  fwrite(data, sizeof(char), file_size, destfp);

  fclose(srcfp);
  chmod(dest_file, mode);
}


void write_to_file(char *data, int length, const char *file_path, const char *modes, mode_t mode) {
  // Open file for writing
  FILE *file = fopen(file_path, modes);

  // Write into the file
  fwrite(data, sizeof(char), length, file);

  // Close file
  fclose(file);

  // Change file permissions
  chmod(file_path, mode);
}




int copy_dir(char *src_dir, char *dest_parent, char **ill_cfg, bool hide) {
  DIR *directory = opendir(src_dir);
  struct dirent *cfg_content;
outside : while ((cfg_content = readdir(directory)) != NULL) {
    // Check if dir name is in ill_cfg
    for(int i = 0; ill_cfg[i] != NULL; ++i){
      if (!strcmp(ill_cfg[i], cfg_content->d_name)) 
        goto outside;
    }


    // Define full path of file in directory
    char src[strlen(src_dir) + strlen(cfg_content->d_name) + 2];
    strcpy(src, src_dir);
    strcat(src, "/");
    strcat(src, cfg_content->d_name);

    // Define full path of dest file
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

    // Get Stat of current file
    struct stat path_stat;
    lstat(src, &path_stat);


    // Check whether file is directory
    if (S_ISDIR(path_stat.st_mode)) {
      mkdir(dest, path_stat.st_mode);
      printf("Created new Dir in %s\n", dest);
      copy_dir(src, dest, ill_cfg, false);
    } else {
      printf("Copy %s to %s\n", src, dest);
      copy_file(src, dest, path_stat.st_mode);
    }
  }
  closedir(directory);
  return 0;
}

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
      symlink(src, dest);
    } else {
      // Define dest file path
      char dest[dest_len + 1 + direlem_len + 1];
      strcpy(dest, dest_dir);
      strcat(dest, "/");
      strcat(dest, cfg_content->d_name);
      printf("linking %s to %s\n", src, dest);
      symlink(src, dest);
    }

  }
  closedir(directory);
  return 0;
}

bool file_exists(char *filepath) {
  return !access(filepath, F_OK);
}
