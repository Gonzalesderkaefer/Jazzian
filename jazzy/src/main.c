/* Other files */
#include "include/def.h"
#include "include/libbackup.h"
#include "include/libconfig.h"
#include "include/libcustom.h"
#include "include/libmove.h"
#include "include/libpacinst.h"
#include "include/utils/config_utils.h"
#include "include/utils/mymenu.h"

void init_system() {
  /* Get Config from user */
  config *system = get_config();

  /* Update system */
  update(system);

  /* Install required packages */
  inst_pac(system);

  /* Transfer config files */
  move_cfg(system->file_transfer);

  /* Create custom config files */
  devicespecific_cfg(system);
}

int main() {
  const char *header = "The jazzy utility";
  const char *prompt = "Your Choice";
  const char *options[] = {"create [b]ackup", "[r]estore backup",
                           "[s]etup system", NULL};

  char choice = print_menu(header, options, prompt);
  flush_stdin();
  switch (choice) {
  case 'b':
    backup_cfgs("myBackup");
    break;
  case 'r':
    restore_cfgs("myBackup");
    break;
  case 's':
    init_system();
    break;
  }
}
