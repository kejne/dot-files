export GOPRIVATE=github.com/WirelessCar-WDP
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go/bin
export PATH=$PATH:/usr/local/go/bin:$HOME/.local/go/bin:$HOME/go/bin:$HOME/bin:$HOME/.local/bin:$GOBIN
export ZSH="$HOME/.oh-my-zsh"
DOTFILES="$HOME/.config/dotfiles"

# source $ZSH/oh-my-zsh.sh
source $DOTFILES/personal/aliases.sh
source $DOTFILES/personal/git-functions.sh
source $DOTFILES/personal/general-functions.sh
# source $DOTFILES/team/functions

# LF config
export EDITOR="nvim"
lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}
alias lf='lfcd'

# Map wacom tablet to single monitor
xinput list | grep Wacom | sed -n 's/.*id=\([0-9]*\).*/\1/p' | xargs -I {} xsetwacom --set {} MapToOutput DP-1-3-8

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source <(kubectl completion zsh)
source $ZSH/plugins/git/git.plugin.zsh
source <(gh completion -s zsh)

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# Add in zsh plugins
zinit ice lucid wait'0'
zinit light zsh-users/zsh-syntax-highlighting
zinit ice lucid wait'0'
zinit light zsh-users/zsh-completions
zinit ice lucid wait'0'
zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait'0'
zinit light Aloxaf/fzf-tab
zinit ice lucid wait'0'
zinit light jeffreytse/zsh-vi-mode
# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

zle_highlight+=(paste:none)

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias ll='ls -al --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
