use crate::config::config;
use crate::menu::menu;

use ratatui::widgets::ListItem;
use std::fmt;

/// Login manager like sddm or gdm
///
/// `LoginManager` is used to define a login manager. These are defined in 'src/config/config.rs'
#[derive(Debug)]
pub struct LoginManager {
    /// Name of this window manager. It's an enum so that is defined in 'src/config/config.rs'
    pub id: config::LoginManagerId,

    /// Packages needed for this Compositor, the index is the DistroId if
    /// an entry is [None] It means the Compositor is not supported for that [Distro]
    pub packages: [Option<&'static [&'static str]>; config::DistroId::Other as usize],

    /// Function that is called after installing this window manager
    pub setup_callback: fn(),
}

/// Implementation of Display for [LoginManagerId] to get `to_string()` for free
impl fmt::Display for config::LoginManagerId {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        return write!(f, "{:?}", self);
    }
}

impl PartialEq for LoginManager {
    fn eq(&self, other: &Self) -> bool {
        return self.id == other.id;
    }
}

/// To convert a [WindowManager] to an [ListItem]
impl<'a> From<&LoginManager> for ListItem<'a> {
    fn from(value: &LoginManager) -> Self {
        return Self::new(value.id.to_string());
    }
}
