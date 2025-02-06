#ifndef DEF_H
#define DEF_H


/* Display server */
typedef enum DISPLAYSERVER { XORG = 0, WAYLAND } DISPLAYSERVER;

/* Windowmanager */
typedef enum WINDOWMANAGER {
  I3 = 0,
  AWESOME,
  BSPWM,
  SWAY,
  HYPRLAND,
  RIVER
} WINDOWMANAGER;

/* Distro */
typedef enum DISTRO { DEBIAN = 0, FEDORA, ARCH, UNKNOWN } DISTRO;

/* Type of transfer */
typedef enum TRANSFER { NOTHING = 0, LINK, COPY } TRANSFER;

/* Config */
typedef struct setup_config {
  DISPLAYSERVER display_manager;
  WINDOWMANAGER window_manager;
  DISTRO distro;
  TRANSFER file_transfer;
} config;



/**
 * @brief returns string representation of provided enum
 * @param dsp displayserver
 */
char *dsp_str(enum DISPLAYSERVER dsp);

/**
 * @brief returns string representation of provided enum
 * @param wm windowmananger
 */
char *wm_str(enum WINDOWMANAGER wm);

/**
 * @brief returns string representation of provided enum
 * @param dist distro
 */
char *dist_str(enum DISTRO dist);

/**
 * @brief returns string representation of provided enum
 * @param tr transfer type
 */
char *tr_str(enum TRANSFER tr);



/**
 * @brief returns string representation of provided config
 * @param cfg config
 */
char *cfg_str(config *cfg);


#endif
