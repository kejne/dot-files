export GOPRIVATE=github.com/cariad-odp/*
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go/bin
export PATH=$PATH:$HOME/.local/go/bin:$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$GOBIN
export ZSH="$HOME/.oh-my-zsh"
DOTFILES="$HOME/.config/dotfiles"

plugins=(z git pip zsh-navigation-tools zsh-interactive-cd terraform golang docker docker-compose zsh-vi-mode kubectl)
bindkey -v

source $ZSH/oh-my-zsh.sh
source $DOTFILES/personal/aliases.sh
source $DOTFILES/personal/git-functions.sh
source $DOTFILES/personal/general-functions.sh
source $DOTFILES/team/functions/functions

# LF config
export EDITOR="nvim"
lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}
alias lf='lfcd'

# Map wacom tablet to single monitor
xsetwacom --set "12" MapToOutput DP-1-3-8
xsetwacom --set "11" MapToOutput DP-1-3-8

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
alias vim=nvim
eval "$(starship init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
