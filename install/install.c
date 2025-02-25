// Other files
#include "def.h"
#include "modules/headers/libconfig.h"
#include "modules/headers/libcustom.h"
#include "modules/headers/libmove.h"
#include "modules/headers/libpacinst.h"
#include "modules/headers/utils/config_utils.h"


int main() {
  // Get Config from user
  config *system = get_config();

  // Update system
  // update(system);

  // Install required packages
  // inst_pac(system);

  // Transfer config files
  // move_cfg(system->file_transfer);

  // Create custom config files
  // devicespecific_cfg(system);
}
