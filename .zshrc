export GOBIN=$HOME/go/bin
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/go/bin:/usr/bin:$GOBIN:$PATH

export ZSH="/home/kejne/.oh-my-zsh"
MYCONFIG='/home/kejne/.myconfig/ubuntu-setup'

ZSH_THEME="agnoster-kejne"
plugins=(git pip autojump zsh-navigation-tools zsh-interactive-cd )

source $ZSH/oh-my-zsh.sh
source $MYCONFIG/aliases
source $MYCONFIG/git-functions
source $MYCONFIG/general-functions

ssh-agent
ssh-add
export DOCKER_HOST=unix:///run/user/1000/docker.sock
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
