# dotfiles
Linux configuration files by Nathaniel Evan. Inspired by various sources.

## Dependencies:
* i3-gaps (window manager), i3lock-color (screen locker), polybar (status bar), rofi (menu)
* rxvt-unicode, urxvt-perls (terminal emulator)
* mpd (music player daemon), ncmpcpp (player client)
* nnn (file manager), trash-cli (trash support)
* neomutt, msmtp, isync, notmuch-runtime (email client)
* gnupg, pass (for password storage)
* udiskie (automounting USB drives)
* vim, vim-airline, vim-fugitive (text editor)
* zsh, zsh-syntax-highlighting, zsh-autosuggestions, [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [Nerd fonts](https://github.com/ryanoasis/nerd-fonts)
* tmux (terminal multiplexer, useful for SSH or tiling in terminal)
* picom (formerly compton, a display compositor)
* xorg-xinit (who needs a display manager?), xorg-xbacklight (screen brightness adjustment)
* scrot (screenshot)
* xss-lock (for screen locking)
* dunst (notification daemon)
* nitrogen (wallpaper setter. debating between this and feh)
* adapta-gtk-theme, papirus-icon-theme (for GTK+ 2 and 3 applications)
* pulseaudio (sound server. it just werks)
* General applications:
  - firefox (web browser. contemplating switching to qutebrowser)
  - zathura (pdf viewer)
  - sxiv (image viewer)
  - glances (system monitor)

## Notes
* These configuration files assume that the target system is running Arch Linux.
* Does not include system-wide configurations, e.g. systemd power management config (which I use in my machine)

## WIP:
* Personal bootstrapping script, if I ever feel like it.
* Set up YouCompleteMe for VIM (and possibly a few other plugins).
* Finish configuring tmux.
* Experiment with awesomewm, bspwm and/or dwm/xmonad, when I'm in the mood to break things.

Suggestions and pull requests welcome, and if I accept yours, I'll credit you in this README and in the corresponding merge commit.

## Screenshot

![Nate's desktop](./screenshot.png?raw=true "Nate's desktop")
