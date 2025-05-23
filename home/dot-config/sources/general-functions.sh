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
