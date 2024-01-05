alias vpn-on='protonvpn-cli c -f'
alias vpn-no='protonvpn-cli d'

alias zshconfig="vim ~/.zshrc"
alias ..='cd ..'
alias ...='cd ../..'

alias skn='sk -n'
alias sd='cd ~ && cd "~/$(find * -type d | fzf)"'
alias home-monitors='xrandr --output DP-1-3-8 --left-of eDP-1 && xrandr --output DP-3 --left-of DP-1-3-8'

# Open Neovim at common repos
alias pnc='cd ~/git/trident/pnc-service && nvim'
alias scc='cd ~/git/trident/scc-service && nvim'
alias tdocs='cd ~/second-brain/trident-docs && nvim'
alias pdocs='cd ~/second-brain/private && nvim'
alias docs='cd ~/second-brain && nvim'
alias pdots='cd ~/.config/dotfiles/personal && nvim'
alias tdots='cd ~/.config/dotfiles/team && nvim'
alias dots='cd ~/.config/dotfiles && nvim'
