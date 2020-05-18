# dotfiles
Linux configuration files by Nathaniel Evan. Inspired by various sources.

## Dependencies:
* `i3-gaps` (window manager), `i3lock-color` (screen locker), `polybar` (status bar), `rofi` (menu)
* `rxvt-unicode`, `urxvt-perls` (terminal emulator)
* `mpd` (music player daemon), `ncmpcpp` (player client)
* `nnn` (file manager), `trash-cli` (trash support)
* `neomutt`, `msmtp`, `isync`, `notmuch-runtime` (email client)
* `gnupg`, `pass` (for password storage)
* `udiskie` (automounting USB drives)
* `vim` (the holy grail of text editors)
  * CoC plugin requires `nodejs` to run
* `zsh`, [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [zsh-autosuggestions](https://github.com/zsh-users/zsh-syntax-highlighting), [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* `fzf` (fuzzy finder, used in zsh and vim)
  * Uses `ripgrep` to find files
* `tmux` (terminal multiplexer, useful for SSH or tiling in terminal)
* `picom` (formerly compton, a display compositor)
* `xorg-xinit` (who needs a display manager?), `xorg-xbacklight` (screen brightness adjustment)
* `maim` (screenshot)
* `xss-lock` (for screen locking)
* `dunst` (notification daemon)
* `nitrogen` (wallpaper setter)
* `pulseaudio` (sound server. it just werks)
* `zathura` (pdf viewer)
* Arc-Dark theme (`arc-gtk-theme` on Arch) (for GTK+ 2 and 3 applications)
* Iosevka Term font (`ttf-iosevka-term` on AUR)

## Notes
* These configuration files assume that the target system is running Arch Linux.
* Does not include system-wide configurations, e.g. systemd power management config (which I use in my machine)

## WIP:
* Personal bootstrapping script, if I ever feel like it.
* Finish configuring tmux.
* Experiment with awesomewm, bspwm and/or dwm/xmonad, when I'm in the mood to break things.

Suggestions and pull requests welcome, and if I accept yours, I'll credit you in this README and in the corresponding merge commit.

## Screenshot

![Nate's desktop](./screenshot.png?raw=true "Nate's desktop")
