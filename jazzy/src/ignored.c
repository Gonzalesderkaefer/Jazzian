/* Libraries */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/* Other files */
#include "include/utils/file_utils.h"

/* Header */
#include "include/ignored.h"



typedef struct _ignored {
    char *name;
    char *src;
    char *dest;
} Ignored;

typedef struct _IgnoredString{
    const char *string;
    const size_t len;
} IgnoredString;


Ignored *ignored_init(const char *name, const char *src, const char *dest) {
    /* Allocate struct */
    Ignored *new_ignored = (Ignored *)malloc(sizeof(Ignored));
    if (!new_ignored) return NULL;

    /* Allocate name */
    if (name) {
        char *ignored_name = (char *)calloc(strlen(name) + 1, sizeof(char));
        if (!ignored_name) {
            free(new_ignored);
            return NULL;
        }
        /* Copy string into buffer */
        snprintf(ignored_name, strlen(name), "%s", name);

        /* Assign string to struct */
        new_ignored->name = ignored_name;

    } else {
        new_ignored->name = NULL;
    }

    /* Allocate src */





    return new_ignored;
}



void ignored_apply(Ignored *to_apply, TRANSFER method) {
    switch(method) {
        case NOTHING:
            return;
        case COPY:
            if (file_exists(to_apply->src) && !file_exists(to_apply->dest))
                copy_dir_r(to_apply->src, to_apply->dest);
            break;
        case LINK:
            if (file_exists(to_apply->src) && !file_exists(to_apply->dest))
                symlink(to_apply->src, to_apply->dest);
            break;
    }

}


void ignored_free(Ignored *to_delete) {
    /* Sanity check */
    if (!to_delete) return;

    /* Free fields */
    free(to_delete->dest);
    free(to_delete->src);
    free(to_delete->name);

    /* Free struct */
    free(to_delete);
}






