alias fsudo='secret-tool lookup fsudo fsudo | sudo -S'
alias system-update='fsudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y'

fsudo-setup () {
  echo "=========================================================================="
  echo "|                           Setting up fsudo                             |"
  echo "|                                                                        |"
  echo "|  This will download libsecret-tools and add your sudo password to      |"
  echo "|  secret-tool.                                                          |"
  echo "=========================================================================="
  echo " "
  echo "Please enter your password:"

  read -s PASS

  echo $PASS | sudo -S apt install libsecret-tools -y
  echo $PASS | secret-tool store --label="fsudo" fsudo fsudo
}

kvim () {
  kitty nvim &
}

replace-all() {
  FROM=$1
  TO=$2
  PWD=$(pwd)

  echo "Replacing all instances of <${FROM}> with <${TO}> in ${PWD}..."
  find ./ -type f -exec sed -i -e "s/$FROM/$TO/g" {} \;
}

awssh() {
  if [[ -z $1 ]]; then
    echo "Please provide a profile."
  else
    aws-vault exec $1 -- zsh
  fi
}

v() {
  if [[ -z $1 ]]; then
    nvim
  else
    [[ -f $1 ]] && nvim $1 || (z $1 && nvim .)
  fi
}
