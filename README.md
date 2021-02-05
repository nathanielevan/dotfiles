# dotfiles
Linux configuration files by Nathaniel Evan. Inspired by various sources.

## Contains configurations for the following:
* `bspwm` (window manager), `betterlockscreen` (screen locker), `sxhkd` (hotkey daemon), `polybar` (status bar), `dmenu` (menu)
* `st` (terminal emulator)
* `zsh` (shell)
* `mpd` (music player daemon), `ncmpcpp` (player client)
* `spotifyd` (Spotify daemon), `spotify-tui` (frontend for `spotifyd`)
* `cava` (audio visualiser)
* `sxiv` (image viewer)
* `nnn`, `ranger` (file managers)
* `neomutt`, `msmtp`, `isync`, `notmuch-runtime` (email client)
* `nvim` (text editor)
* `tmux` (terminal multiplexer)
* `picom` (formerly compton, a display compositor)
  - Dual kawase blur requires `picom-git` for now
* `xorg-xinit` (who needs a display manager?)
* `dunst` (notification daemon), `libnotify` (library for sending notifications)
* `zathura` (pdf viewer)
* `weechat` (IRC client)
* `gotop` (system monitor)

## Dependencies:
* `nodejs` (for running coc.nvim), `ripgrep`, `bat` (for fzf.vim)
* `maim` (screenshot)
* `xss-lock` (for screen locking)
* `xorg-xbacklight` (screen brightness adjustment)
* `udiskie` (automounting USB drives)
* `playerctl` (here used for spotifyd notifications)
* `atool` (extract archive files)
* `trash-cli` (optional, for trash function in nnn and fern.vim)
* `pulseaudio` (sound server)
* Arc-Dark GTK theme (`arc-gtk-theme` on Arch) (for GTK+ 2 and 3 applications)
* Arc icon theme (`arc-icon-theme` on Arch)
* Iosevka Nerd Font Mono font

## Notes
* These configuration files assume that the target system is running Arch Linux.
* Does not include system-wide configurations, e.g. systemd power management config (which I use in my machine)

## WIP:
* Personal bootstrapping script, if I ever feel like it.
* Finish configuring tmux.
* Experiment with awesomewm, ~~bspwm~~ and/or dwm/xmonad, when I'm in the mood to break things.

Suggestions and pull requests welcome, and if I accept yours, I'll credit you in this README and in the corresponding merge commit.

## Screenshot

![Screenshot](screenshot.png?raw=true)
