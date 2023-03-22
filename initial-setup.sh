#/bin/bash

echo "####################################################"
echo "#   1. Updating system                             #"
echo "####################################################"

sudo apt update -y && sudo apt upgrade -y && sudo apt-dist-upgrade -y && sudo apt autoremove -y

echo "####################################################"
echo "#   2. Installing packages                         #"
echo "####################################################"

sudo apt install p7zip-full libsecret-tools git openjdk-11-jdk maven python3 python3-pip python-is-python3 zsh curl fonts-powerline flameshot fzf autojump -y

sudo snap install code --classic

wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'
sudo apt-get update && sudo apt-get install protonvpn -y

echo "####################################################"
echo "#   3. Setting up zsh                              #"
echo "####################################################"

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc
cd ~
ln -s ~/.myconfig/ubuntu-setup/.zshrc
cp ~/.myconfig/ubuntu-setup/agnoster-kejne.zsh-theme ~/.oh-my-zsh/themes/
