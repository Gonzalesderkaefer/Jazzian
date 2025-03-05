#include "include/utils/pkgutils.h"

int lst_len(const char **lst) {
  int len = 0;
  for (; lst[len] != NULL; ++len); 
  return len;
}
