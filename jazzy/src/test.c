#include "./include/ignored.h"
#include "include/def.h"
#include <string.h>

int main() {
    char dir[] = "/home/user1/Jazzian/jazzy";
    puts(dir);
    char *lastchar = strrchr(dir, '/');
    *lastchar = '\0';
    puts(dir);
}
