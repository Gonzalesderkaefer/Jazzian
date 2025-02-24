// Other files
#include "def.h"
#include "modules/pac_inst.c"
#include "modules/custom.c"
#include "modules/config.c"
#include "modules/move.c"


int main() {
    // Get Config from user
    config *system = get_config();

    // Install required packages
    inst_pac(system);

    // Transfer config files
    move_cfg(system->file_transfer);

    // Create custom config files
    devicespecific_cfg(system);
}
