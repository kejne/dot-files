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
  if [ "$#" -ne 2 ]; then
     echo "Usage example: replace-all <from> <to>"
     exit 1;
  fi
  echo '$1 $2'
  #find ./ -type f -exec sed -i -e 's/$0/$1/g' {} \;
}
