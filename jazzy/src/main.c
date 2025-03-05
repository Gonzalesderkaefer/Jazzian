// Other files
#include "include/def.h"
#include "include/libconfig.h"
#include "include/libcustom.h"
#include "include/libmove.h"
#include "include/libpacinst.h"
#include "include/utils/config_utils.h"
#include "include/utils/mymenu.h"
#include "include/libbackup.h"



int main() {
  const char *header = "The jazzy utility";
  const char *prompt = "Your Choice";
  const char *options[] = {
    "create [b]ackup",
    "[r]estore backup",
    "[s]etup system",
    NULL
  };

  char choice = print_menu(header, options, prompt);
  printf("%c\n", choice);
}



void init_system() {
  // Get Config from user
  config *system = get_config();

  // Update system
  update(system);

  // Install required packages
  inst_pac(system);

  // Transfer config files
  move_cfg(system->file_transfer);

  // Create custom config files
  devicespecific_cfg(system);
}
