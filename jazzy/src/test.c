#include "./include/ignored.h"
#include "include/def.h"
#include <string.h>

int main() {
    char path[] = "/home/user1/myBackup.bac/i3/devicespecific";
    const size_t pathlen = strlen(path);
    char dir[pathlen + 1];
    memset(dir, '\0', pathlen + 1);

    char *token, *pretoken, *rest;
    rest = path;
    pretoken = "";
    while ((token = strtok_r(rest, "/", &rest))) {
        strncat(dir, pretoken, pathlen - strlen(dir) - 1);
        strncat(dir, "/", pathlen - strlen(dir) - 1);
        pretoken = token;
    }

    puts(dir);





}
