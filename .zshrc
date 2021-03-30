export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/home/kejne/.oh-my-zsh"
MYCONFIG='/home/kejne/.myconfig/ubuntu-setup'

ZSH_THEME="agnoster"
plugins=(git pip zsh-navigation-tools zsh_reload autojump zsh-navigation-tools zsh-interactive-cd )

source $ZSH/oh-my-zsh.sh
source $MYCONFIG/aliases
source $MYCONFIG/git-functions
source $MYCONFIG/general-functions
