#include "../../../def.h"


#ifndef SEAREP_C
#define SEAREP_C


[[nodiscard]]
char *rep_interval(char *freeable, int start, int end, char *insertion);

[[nodiscard]]
char *search_replace(char *freeable, char *regexp, char *substitute);


#endif
