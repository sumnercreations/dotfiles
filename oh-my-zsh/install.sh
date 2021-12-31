# pretty logging
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

# Install oh my zsh
info '> Start Oh My ZSH'
if [ ! -e "$ZSH" ]; then
    info '> Oh My ZSH not found; installing...'
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    success "> Oh My ZSH already installed: $ZSH"
fi

# Installing zgen (zsh plugin manager for oh-my-zsh)
info '> Start zgen'
zgen_dir=~/.zgen
if [ ! -e "$zgen_dir" ]; then
    info '> zgen not found; installing...'
    mkdir -p "$zgen_dir"
    git clone https://github.com/tarjoilija/zgen.git "$zgen_dir"
else
    success "> zgen already installed. $zgen_dir"
fi