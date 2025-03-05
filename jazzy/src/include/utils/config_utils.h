#include "../def.h"


char *wm_tostr(WINDOWMANAGER wm);
char *dsp_tostr(DISPLAYSERVER dsp);
char *transfer_tostr(TRANSFER transfer);
char *distro_tostr(DISTRO distro);



[[nodiscard("Heap allocated return value must be free'd")]]
char *config_tostr(config *system);
