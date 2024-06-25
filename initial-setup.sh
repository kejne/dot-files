# #/bin/bash
# 
# echo "####################################################"
# echo "#   1. Updating system                             #"
# echo "####################################################"
# wget -qO - https://regolith-desktop.org/regolith.key | \
# gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
# 
# echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
# https://regolith-desktop.org/release-3_1-ubuntu-jammy-amd64 jammy main" | \
# sudo tee /etc/apt/sources.list.d/regolith.list
# 
# sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
# 
# echo "####################################################"
# echo "#   2. Installing packages                         #"
# echo "####################################################"
# 
# sudo apt install p7zip-full libsecret-tools git python3 python3-pip python-is-python3 zsh curl fonts-powerline flameshot build-essential regolith-desktop regolith-session-flashback regolith-look-gruvbox i3xrocks-battery i3xrocks-memory gpg pass ripgrep -y
# 
# sudo snap install code obsidian --classic
# sudo snap install --beta nvim --classic
# sudo snap install slack firefox spotify
# 
# echo "####################################################"
# echo "#   3. Setting up zsh                              #"
# echo "####################################################"
# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# cd ~/.local/bin
# ln -s ~/.local/kitty.app/bin/kitty
# ln -s ~/.local/kitty.app/bin/kitten
# 
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# brew install gcc starship kubectl gh golang helm fzf zoxide rust bat
# 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# gh auth login
# cd ~
# mkdir -p git/kaj
# cd git/kaj
# gh repo clone kejne/dot-files

rm ~/.zshrc || echo ".zshrc already cleaned"
mkdir -p ~/.config/dotfiles/
cd ~/.config/dotfiles/
ln -s ~/git/kaj/dot-files personal
cd ~
ln -s ~/.config/dotfiles/personal/.zshrc
cd ~/.config
rm -rf regolith3
ln -s ~/.config/dotfiles/personal/starship.toml
ln -s ~/.config/dotfiles/personal/regolith2 regolith3
ln -s ~/.config/dotfiles/personal/nvim


cd ~/git/kaj
gh repo clone kejne/second-brain
mkdir -p ~/second-brain/default

cd ~/second-brain
ln -s ~/git/kaj/second-brain personal

env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
go install github.com/erikkinding/sk
