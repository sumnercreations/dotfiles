# My dotfiles

# Credit
I based these dotfiles on two popular dotfiles.
[Zach Holman](https://github.com/holman/dotfiles) and [Ryan Bates](https://github.com/ryanb/dotfiles)

I had originally forked holman's but it didn't support Oh My ZSH, which I really like, and so I did some research and saw an issue on his repository with a few suggestions, but they didn't solve it easily for me and so I went back to Google. That's when I found Ryan's dotfiles. I liked that his supports Oh My ZSH, but then I missed out on the organization that Holman had. So, I built these dotfiles. They most closely resemble Holman's. 

Thank you to both of them.

## Install / Run
Run this:

```sh
git clone https://github.com/sumnercreations/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

Running that will do the following:
1. Add all the symlinks.
  a. We look for all files in the directory with the extension `.symlink`. All of these will be linked to the home directory with preceeded with a `.`
  ie: `oh-my-zsh/zshrc.symlink` will be symlinked to `~/.zshrc`
2. Generates an SSH Key, copies it and opens Github so you can save copy it there.
3. Set the default shell to zsh so we can use Oh My ZSH
Steps 4 and 5 next steps are only run on a Mac OSX environment
4. Install Homebrew and all the apps within the `Brewfile`
5. Run all the `dot` file which sets some Mac OS X defaults and runs all files in the folder with the filename `install.sh`
6. (4 if not on Mac) zshrc file adds paths, completions, Oh My ZSH plugins, and aliases. (see zshrc file info below)

### zshrc file
The `zshrc` file is where a lot of magic happens. In this file we do the following:
1. Load Oh My ZSH and set defaults
2. Set the Editor. ** I use `code-insiders`, change this to your editor of choice.**
3. Add all files in the directory with the name `path.sh` to the path. `macos/path.sh` adds all the files in `bin` to the `$PATH` variable.
4. Load zgen and the oh my zsh plugins. ** These are the plugins I like. Feel free to change these to anything you like**
5. Add all files in the directory with the name `aliases.sh` to the file as aliases.
6. Sets up a better history which allows for finding only previous commands that match up to where the cursor is. https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
7. Setup rbenv that was installed through Brew.

## Notes
Completions are being handled by `zsh-users/zsh-completions` in oh my zsh
iTerm2 settings
- Change the font in `Preferences > Profiles > text > Font > Change Font` also check `Use a different font for non-ASCII text` and select the font there too.
- Change the color Presets to `Tango Dark` in `Preferences > Profiles > Colors`