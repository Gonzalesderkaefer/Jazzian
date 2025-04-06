/* Libraries */
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


Ignored *ignored_init(char *name, char *src, char *dest) {
    /* Allocate struct */
    Ignored *newignored = (Ignored *)malloc(sizeof(Ignored));
    if (!newignored)
        return NULL;

    /* Name */
    if(name) {
        newignored->name = (char *)calloc(strlen(name) + 1, sizeof(char));
        if(!newignored->name) {
            free(newignored);
            return NULL;
        }
    } else {
        newignored->name = NULL;
    }

    /* src */
    if(src) {
        newignored->src = (char *)calloc(strlen(src) + 1, sizeof(char));
        if(!newignored->src) {
            free(newignored->name);
            free(newignored);
            return NULL;
        }
    } else {
        newignored->src = NULL;
    }

    /* dest */
    if(dest) {
        newignored->dest = (char *)calloc(strlen(dest) + 1, sizeof(char));
        if(!newignored->dest) {
            free(newignored->src);
            free(newignored->name);
            free(newignored);
            return NULL;
        }
    } else {
        newignored->dest = NULL;
    }

    return newignored;
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






