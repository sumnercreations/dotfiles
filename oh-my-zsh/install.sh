# Install oh my zsh
echo '> Installing Oh My ZSH'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Installing zgen (zsh plugin manager for oh-my-zsh)
echo '> Installing zgen'
zgen_dir=~/.zgen
if [ ! -e "$zgen_dir" ]; then
    mkdir -p "$zgen_dir"
    git clone https://github.com/tarjoilija/zgen.git "$zgen_dir"
fi