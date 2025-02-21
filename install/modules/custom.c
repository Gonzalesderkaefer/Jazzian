#include "../def.h"
#include "../utils/file_utils.c"


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

char *mdmenu =
  "#!/usr/bin/sh\n"
  "rofi_dmenu\n";

char *mdrun =
  "#!/usr/bin/sh\n"
  "rofi_app\n";

int main() {
}
