#include "./include/ignored.h"
#include "include/def.h"

int main() {
    Ignored *ig = ignored_init("vim", "/Jazzian/cfg_files/vim", "/.vim");
    ignored_apply(ig, LINK);
    ignored_free(ig);
}
