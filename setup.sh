#!/usr/bin/env bash
#
# setup will set up the environment
# Based on the scripts/bootstrap file from https://github.com/holman/dotfiles

DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

add_symlinks () {
  info 'adding symlinks test'

  local overwrite_all=false backup_all=false skip_all=false
  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
  success "Added Symlinks"
}

# Check for a SSH key, generate a new one if it doesn't exist
generate_ssh_key () {
  pub=$HOME/.ssh/id_rsa.pub
  info 'Checking for SSH key, generating one if it does not exist...'
    [[ -f $pub ]] || ssh-keygen -t rsa

  info 'Copying public key to clipboard. Paste it into your Github account...'
    [[ -f $pub ]] && cat $pub | pbcopy
    open 'https://github.com/account/ssh'
}

# Change default shell to zsh
set_default_shell () {
  if [[ "$SHELL" != *zsh ]]; then
    info "Making zsh the default shell"
    chsh -s $(which zsh)
  fi
}

# Start the Setup
add_symlinks
# generate_ssh_key
set_default_shell
# Add /bin to $PATH
export PATH=$PATH:~/.dotfiles/bin

# If we're on a Mac, let's install and setup homebrew.
if [ "$(uname -s)" == "Darwin" ]
then
  info "installing dependencies"
  if source bin/dot | while read -r data; do info "$data"; done
  then
    success "dependencies installed"
  else
    fail "error installing dependencies"
  fi
fi

echo ''
echo '  All installed!'