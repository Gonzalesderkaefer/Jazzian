#![allow(unused_imports)]
mod computer;
mod config;
mod menu;
mod utils;

use computer::transfer;
use config::config as cfg;
use config::custom as cstm;
use std::{
    env::home_dir,
    ffi::OsStr,
    io,
    path::{Path, PathBuf},
    result,
};
use utils::fileutils as fu;

use crate::{computer::dsp_server, utils::command as cmd};

fn main() {
    match run() {
        Ok(_) => {}
        Err(error) => println!("{error}"),
    };
}

fn run() -> Result<(), JazzyErr> {
    // Get the home directory
    let home_dir = match std::env::home_dir() {
        Some(home) => home,
        None => return Err(JazzyErr::NoHome(line!(), file!())),
    };

    let shell = match std::env::var("SHELL") {
        Ok(shell) => shell,
        Err(_) => String::from("/usr/bin/bash"),
    };

    let home_str = match home_dir.to_str() {
        Some(string) => string,
        None => return Err(JazzyErr::NoHome(line!(), file!())),
    };

    // Get the computer
    let computer = match computer::computer::Computer::get() {
        Ok(mach) => mach,
        Err(error) => return Err(JazzyErr::ComputerErr(error, line!(), file!())),
    };

    // Patch for now need to make this 'cleaner'
    if computer.distro.id == cfg::DistroId::Other {
        // move the config files
        movedir(
            &home_dir,
            cfg::CFGSRC,
            cfg::CFGDEST,
            &computer.transfer,
            false,
        )?;

        // move the scripts
        movedir(
            &home_dir,
            cfg::BINSRC,
            cfg::BINDEST,
            &computer.transfer,
            false,
        )?;

        // move the shell configuratons
        movedir(&home_dir, cfg::SHELLCFG, home_str, &computer.transfer, true)?;
        return Ok(());
    }

    // Update the computer
    match computer.update() {
        Ok(_) => {}
        Err(error) => return Err(JazzyErr::ComputerErr(error, line!(), file!())),
    }

    // Install the packages
    match computer.install() {
        Ok(_) => {}
        Err(error) => return Err(JazzyErr::ComputerErr(error, line!(), file!())),
    }

    // Create files
    for file in cstm::CUSTOMIZED {
        match fu::create_and_write_user(file.0, file.1, file.2) {
            Ok(_) => {}
            Err(error) => println!("Error creating file {}: {error}", file.0),
        }
    }

    match computer.enable_gui() {
        Ok(_) => {}
        Err(error) => return Err(JazzyErr::ComputerErr(error, line!(), file!())),
    };

    // Setup the computer
    (computer.display_server.setup_callback)();
    (computer.login_manager.setup_callback)();
    (computer.distro.setup_callback)();
    (computer.gui.setup_callback)();

    // Run final commands

    // Gsettings stuff for theming
    cmd(
        "gsettings",
        &[
            "set",
            "org.gnome.desktop.interface",
            "gtk-theme",
            "\'Adwaita-dark\'",
        ],
    );
    cmd(
        "gsettings",
        &[
            "set",
            "org.gnome.desktop.interface",
            "color-scheme",
            "\'prefer-dark\'",
        ],
    );
    cmd(
        "gsettings",
        &[
            "set",
            "org.gnome.desktop.interface",
            "icon-theme",
            "\'Papirus-Dark\'",
        ],
    );
    cmd(
        "gsettings",
        &[
            "set",
            "org.gnome.desktop.interface",
            "font-name",
            "\'Jetbrains Mono\'",
        ],
    );

    if let None = shell.find("zsh") {
        // Clear the screen
        print!("{}[2J", 27 as char);

        // Change the shell
        println!(
            "{}Changing the shell to zsh. You will be prompted for your user password{}",
            FgColor!(Green),
            FgColor!()
        );
        cmd("chsh", &["-s", "/usr/bin/zsh"]);
    }

    return Ok(());
}

/// Moves `src` to `dest` according to `method`. `src`  and `dest` need to be relative to
/// `home_dir`.
pub fn movedir<P: AsRef<Path>>(
    home_dir: &PathBuf,
    src: P,
    dest: P,
    method: &transfer::Transfer,
    hide: bool,
) -> Result<(), JazzyErr> {
    // Create full src path
    let mut src_path_buf = home_dir.clone();
    src_path_buf.push(src);

    // Create full dest path
    let mut dest_path_buf = home_dir.clone();
    dest_path_buf.push(dest);

    match fu::move_dir(src_path_buf, dest_path_buf, method.clone(), hide) {
        Ok(_) => return Ok(()),
        Err(error) => return Err(JazzyErr::FileUtil(error, line!(), file!())),
    }
}

/// The main error type for this program. Functions in this module and setup_callback functions
/// for the computer-sub types will return this error.
#[derive(Debug)]
pub enum JazzyErr {
    IO(io::Error),
    ComputerErr(computer::computer::ComputerError, u32, &'static str),
    FileUtil(fu::FileUtilErr, u32, &'static str),
    NoHome(u32, &'static str),
    Command(cmd::CommandError, u32, &'static str),
}
impl std::error::Error for JazzyErr {}

impl std::fmt::Display for JazzyErr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match &self {
            JazzyErr::IO(error) => return write!(f, "Internal IO Error at: {error}"),
            JazzyErr::ComputerErr(error, line, file) => {
                return write!(f, "computer Error at {line} in {file} :{error}");
            }
            JazzyErr::FileUtil(error, line, file) => {
                return write!(f, "File Error at {line} in {file} : {error}");
            }
            JazzyErr::NoHome(line, file) => return write!(f, "No $HOME found at: {line}, {file}"),
            JazzyErr::Command(error, line, file) => {
                return write!(f, "Error running command at {line}, {file}: {error}");
            }
        }
    }
}

// Helper functions.
// These will just print an error to stdout and return nothing
fn cmd<S: AsRef<OsStr> + Clone>(command: S, args: &[S]) {
    match cmd::cmd(command.clone(), args) {
        Ok(_) => {}
        Err(error) => println!(
            "Failed to run {} in {} : {error}",
            command.as_ref().display(),
            file!()
        ),
    }
}

/*
fn create_and_write_user<P: AsRef<Path> + Clone, C: AsRef<[u8]>>(new_file: P, contents: C, mode: u32) {
    match fu::create_and_write_user(new_file.clone(), contents, mode) {
        Ok(_) => {}
        Err(error) => println!("Failed to create file {}: {error}", new_file.as_ref().display()),
    }

}
*/
