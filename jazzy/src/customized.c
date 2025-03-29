#include <stdbool.h>
#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/stat.h>

/* Other files */
#include "include/utils/file_utils.h"


/* Headers */
#include "include/customized.h"


void customized(char *relpath, char *contents, mode_t mode, bool customperm) {
    /* Build absolute file path */
    char filepath[strlen(getenv("HOME")) + strlen(relpath) + 1];
    sprintf(filepath, "%s%s", getenv("HOME"), relpath);

    /* Check if filepath exists */
    if (file_exists(filepath)) 
        return;

    /* Check whether dir or regular file */
    char end = filepath[strlen(filepath) - 1];
    if (end == '/' && !file_exists(filepath)) {
        mkdir_r(filepath, 0755);
    } else {
        /* Get last component */
        char fullpath[strlen(filepath) + 1];
        strcpy(fullpath, filepath);

        char *pretok, *token, *rest, *svptr;
        rest = fullpath;
        while((token = strtok_r(rest, "/", &rest)))
            pretok = token;


        /* cut path */
        size_t cutpathlen = strlen(filepath) - strlen(pretok);
        char cutpath[cutpathlen + 1];
        memset(cutpath, '\0', cutpathlen + 1);
        strncpy(cutpath, filepath, cutpathlen);

        /* Create dir */
        if (!file_exists(cutpath))
            mkdir_r(cutpath, 0775);

        /* Write to file */
        FILE *fp = fopen(filepath, "w+");
        fwrite(contents, strlen(contents), sizeof(char), fp);
        fclose(fp);

        /* Set file mode */
        if (customperm)
            chmod(filepath, mode);
    }
}
