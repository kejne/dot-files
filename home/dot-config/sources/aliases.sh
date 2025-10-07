alias vpn-on='protonvpn-cli c -f'
alias vpn-no='protonvpn-cli d'
alias vpnup='nmcli con up id WirelessCar_vpn'

alias zshconfig="vim ~/.zshrc"
alias ..='cd ..'
alias ...='cd ../..'

alias ls=eza
alias ll='eza -al'
alias k=kubectl
alias t=task
alias m=mise
alias v=nvim
alias ks='k9s'
alias skn='sk -n'
alias skN='sk -N'
alias sd='cd ~/git && cd "~/git/$(find * -type d | fzf)"'

# Open Neovim at common locations
alias vv='cd ~/git/src/github.com && nvim'
alias tdocs='cd ~/second-brain/team && nvim'
alias tdots='cd ~/.config/dotfiles/team && nvim'
alias pdocs='cd ~/second-brain/personal && nvim'
alias pdots='cd ~/.config/dotfiles/personal && nvim'
alias docs='cd ~/second-brain/personal && nvim'
alias dots='cd ~/.config/dotfiles/personal && nvim'

# Mise
alias mtl='mise tasks ls'
alias mr='mise run'
