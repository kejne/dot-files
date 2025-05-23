#/bin/bash

$DOTFILES_DIR=$(pwd)
wget -qO - https://regolith-desktop.org/regolith.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null
echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
https://regolith-desktop.org/release-3_2-ubuntu-noble-amd64 noble main" | \
sudo tee /etc/apt/sources.list.d/regolith.list

sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

sudo apt install p7zip-full libsecret-tools git python3 python3-pip python-is-python3 zsh curl fonts-powerline flameshot build-essential regolith-desktop regolith-session-flashback regolith-look-gruvbox i3xrocks-battery i3xrocks-memory gpg pass ripgrep direnv libreadline-dev luarocks lua-5.1 -y

sudo snap install code obsidian --classic
sudo snap install slack firefox spotify

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 0x7413A06D
curl https://mise.jdx.dev/install.sh.sig | gpg --decrypt > mise.sh
# ensure the above is signed with the mise release key
chmod u+x mise.sh
sh ./mise.sh
rm ./mise.sh

stow -t ~/ -S home --dotfiles
mise upgrade

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install gcc neovim

~/.tmux/plugins/tpm/bin/install_plugins

gh auth login

rm ~/.zshrc || echo ".zshrc already cleaned"

gh repo clone kejne/second-brain ../second-brain
mkdir -p ~/second-brain/personal
stow -d ../ -t ~/second-brain/personal -S second-brain
