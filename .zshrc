export GOBIN=$HOME/go/bin
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/go/bin:/usr/bin:$GOBIN:$PATH

export ZSH="$HOME/.oh-my-zsh"
MYCONFIG="$HOME/dotfiles"

ZSH_THEME="agnoster-kejne"
plugins=(git pip z zsh-navigation-tools zsh-interactive-cd zsh-vi-mode)

source $ZSH/oh-my-zsh.sh
source $MYCONFIG/aliases
source $MYCONFIG/git-functions
source $MYCONFIG/general-functions

alias vim=nvim

export DOCKER_HOST=unix:///run/user/1000/docker.sock
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

