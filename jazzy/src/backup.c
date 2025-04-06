#include "include/backup.h"
#include "include/utils/file_utils.h"
#include <string.h>
#include <sys/stat.h>

#define HOME getenv("HOME")


static void _create_backup(const char *srcfile, const char *destfile) {
    /* Build src */
    size_t srclen = strlen(srcfile) + strlen(HOME) + 1;
    char src[srclen];
    sprintf(src, "%s%s", HOME, srcfile);


    /* Build dest */
    size_t destlen = strlen(destfile) + strlen(HOME) + 1;
    char dest[destlen];
    sprintf(dest, "%s%s", HOME, destfile);

    /* Determine filetype */
    struct stat srcstat;
    lstat(src, &srcstat);

    if(S_ISDIR(srcstat.st_mode)) {
        copy_dir_r(src, dest);
    } else {
        copy_file(src,dest,srcstat.st_mode);
    }
}



int backup_cfgs(char *backup_name) {

    /* Customized files for window managers/compositors */
    _create_backup("/.config/sway/devicespecific", "/myBackup/sway");
    _create_backup("/.config/hypr/devicespecific", "/myBackup/hypr");
    _create_backup("/.config/river/devicespecific", "/myBackup/river");
    _create_backup("/.config/i3/devicespecific", "/myBackup/i3");
    _create_backup("/.config/awesome/devicespecific", "/myBackup/awesome");
    _create_backup("/.config/bspwm/devicespecific", "/myBackup/bspwm");

    /* Customized shell files */
    _create_backup("/.devicespecific.sh", "/myBackup/devicespecific.sh");
    _create_backup("/.devicerc", "/myBackup/devicerc");

    /* X11 startup */
    _create_backup("/.local/bin/x11startup", "/myBackup/x11startup");


    /* xinitrc */
    _create_backup("/.xinitrc", "/myBackup/xinitrc");


    return 0;
}









int restore_cfgs(char *backup_name) {
}











