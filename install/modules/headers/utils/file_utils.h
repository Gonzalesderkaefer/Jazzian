#ifndef FILE_UTILS_C
#define FILE_UTILS_C

// Other files
#include "../../../def.h"


#define file_exists(filepath) !access(filepath, F_OK)


void copy_file(char *src_file, char *dest_file, mode_t mode);

void write_to_file(char *data, int length, const char *file_path, const char *modes, mode_t mode);

int copy_dir(char *src_dir, char *dest_parent, char **ill_cfg, bool hide);

int link_dir(char *src_dir, char *dest_dir, char **ill_cfg, bool hide);

#endif
