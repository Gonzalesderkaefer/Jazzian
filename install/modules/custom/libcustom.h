#include "../../def.h"
#include "../../utils/file_utils.c"


char *devicespecific_sh =
  "killshells() {\n"
  "    pkill -KILL -u $USER -t tty1\n"
  "}\n"
  "export WM=i3\n"
  "[ \"$(tty)\" = \"/dev/tty1\" ] && (startx; killshells)\n";

char *debmdmenu = 
  "#!/usr/bin/sh\n"
  "if [ $XDG_SESSION_TYPE = \"wayland\" ]; then\n"
  "    wofi_dmenu;\n"
  "else\n"
  "    rofi_dmenu;\n"
  "fi\n";

char *debmdrun = 
  "#!/usr/bin/sh\n"
  "if [ $XDG_SESSION_TYPE = \"wayland\" ]; then\n"
  "    wofi_app;\n"
  "else\n"
  "    rofi_app;\n"
  "fi\n";

char *mdmenu_content =
  "#!/usr/bin/sh\n"
  "rofi_dmenu\n";

char *mdrun_content =
  "#!/usr/bin/sh\n"
  "rofi_app\n";

char *myterm_content =
"    #!/bin/dash\n"
"    case $XDG_SESSION_TYPE in\n"
"        \"wayland\")\n"
"            alacritty -o font.size=12\n"
"            ;;\n"
"        *)\n"
"            alacritty -o font.size=12\n"
"            ;;\n"
"    esac\n";

void devicespecific_cfg(config *);
