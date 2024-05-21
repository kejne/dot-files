alias vpn-on='protonvpn-cli c -f'
alias vpn-no='protonvpn-cli d'

alias zshconfig="vim ~/.zshrc"
alias ..='cd ..'
alias ...='cd ../..'

alias ks='k9s'
alias v='nvim'
alias skn='sk -n'
alias skN='sk -N'
alias sd='cd ~/git && cd "~/git/$(find * -type d | fzf)"'
alias home-monitors='xrandr --output DP-1-3-8 --left-of eDP-1 && xrandr --output DP-3 --left-of DP-1-3-8'

# Open Neovim at common repos
alias twork='cd ~/git/trailblazers && nvim'
alias tdocs='cd ~/second-brain/team && nvim'
alias tdots='cd ~/.config/dotfiles/team && nvim'
alias pdocs='cd ~/second-brain/personal && nvim'
alias pdots='cd ~/.config/dotfiles/personal && nvim'
alias docs='cd ~/second-brain && nvim'
alias dots='cd ~/.config/dotfiles && nvim'
