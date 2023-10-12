export GOPRIVATE=github.com/cariad-odp/*
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go/bin
export PATH=$PATH:$HOME/.local/go/bin:$HOME/go/bin
export ZSH="$HOME/.oh-my-zsh"
DOTFILES="$HOME/.config/dotfiles"

plugins=(z git pip zsh-navigation-tools zsh-interactive-cd terraform golang docker docker-compose zsh-vi-mode kubectl)
ZSH_THEME="agnoster-kejne"
bindkey -v

source $ZSH/oh-my-zsh.sh
source $DOTFILES/personal/aliases.sh
source $DOTFILES/personal/git-functions.sh
source $DOTFILES/personal/general-functions.sh
source $DOTFILES/team/functions/functions

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
