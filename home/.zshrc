export GOPRIVATE=github.com/WirelessCar-WDP,github.com/WDP-*
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go/bin
export CARGOBIN=$HOME/.cargo/bin
export PATH=$PATH:/usr/local/go/bin:$HOME/.local/go/bin:$HOME/bin:$HOME/.local/bin:$GOBIN:$CARGOBIN
export ZSH="$HOME/.oh-my-zsh"
export BAT_THEME=gruvbox-dark
export ANTHROPIC_API_KEY=$(pass show anthropic)

# Source all files under $HOME/.config/sources/
for file in $HOME/.config/sources/*.sh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# LF config
export EDITOR="nvim"
lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}
alias lf='lfcd'

# Map wacom tablet to single monitor
MONITOR=$(xrandr | grep " connected.*597" | cut -d " " -f 1 -)
xinput list | grep Wacom | sed -n 's/.*id=\([0-9]*\).*/\1/p' | xargs -I {} xsetwacom --set {} MapToOutput $MONITOR
/usr/bin/setxkbmap -option "ctrl:nocaps"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


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
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

eval "$(gh copilot alias -- zsh)"
[ -s "drv" ] && \. source <(drv completion zsh)
source <(kubectl completion zsh)
source <(gh completion -s zsh)
