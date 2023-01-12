# dotfiles
Linux configuration files by Nathaniel Evan. Inspired by various sources. As seen on [this r/unixporn post](https://www.reddit.com/r/unixporn/comments/wijdko/openbox_grooooooovboks_material_edition).

Previous dwm rice is [here](https://www.reddit.com/r/unixporn/comments/mewpsp/dwm_still_lovin_nord/).

Other relevant links:
* [Gruvbox Material Theme for Openbox](https://github.com/nathanielevan/gruvbox-material-openbox)
* [Gruvbox Material Theme for Telegram](https://github.com/nathanielevan/gruvbox-material-telegram)
* [Startpage](https://github.com/nathanielevan/startpage)

## Directory
* `.config` is where my configuration files reside.
    + You can find my wallpaper in `.config/wallpapers`.
* `.local/bin` is where I store miscellaneous shell scripts for e.g. dwmblocks, power menu, monitor switching menu etc.
* `.local/share` contains miscellaneous files e.g. desktop files, zsh plugins, custom font builds etc.

## Notes
* These configuration files assume that the target system is running Arch Linux.
* Does not include system-wide configurations, e.g. systemd power management config (which I use in my machine)
* Due to the size of this repo, use `git clone --depth=1` or download the ZIP archive [here](https://github.com/nathanielevan/dotfiles/archive/refs/heads/master.zip) if you just need to get the files.

## WIP:
* Personal bootstrapping script, if I ever feel like it.
* Finish configuring tmux.
* Experiment with awesomewm, ~~bspwm~~, ~~dwm~~/xmonad, and/or ~~openbox~~ when I'm in the mood to break things.

Suggestions and pull requests welcome, and if I accept yours, I'll credit you in this README and in the corresponding merge commit.

## Contributions:
* Thanks to [@Zish1805](https://github.com/Z-8Bit) for fixing the battery charging animation foreground colour on Polybar!

## Screenshot

### openbox
![openbox](https://user-images.githubusercontent.com/9361126/212205066-5a6eec81-bc86-410d-bb0c-e7c400f3fcb3.png)

### bspwm
![bspwm](https://user-images.githubusercontent.com/9361126/212205104-3a87139b-184c-4dd2-b034-5ae211036904.png)

### dwm
![dwm](https://user-images.githubusercontent.com/9361126/212205132-237c2d63-0846-4a28-ad81-68b07138c33e.png)

Check out my suckless builds here:
* [dwm](https://github.com/nathanielevan/dwm) + [dwmblocks](https://github.com/nathanielevan/dwmblocks)
* [dmenu](https://github.com/nathanielevan/dmenu)
* [st](https://github.com/nathanielevan/st)
* [slock](https://github.com/nathanielevan/slock)
* [tabbed](https://github.com/nathanielevan/tabbed)
