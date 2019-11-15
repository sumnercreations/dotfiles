# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

alias dev="cd ~/Developer/"
alias sites="cd ~/Sites/"

# NAV
alias nav="cd ~/Sites/nav/wp/wp-content/themes/nav-2015"
