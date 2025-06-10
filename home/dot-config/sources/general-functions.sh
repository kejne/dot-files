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

z() {
	if [[ $# -eq 1 ]]; then
		selected=$1
	else
		selected=$(find ~/git/github.com/ ~/git/src/github.com -mindepth 1 -type d 2>/dev/null | \
			sed "s|^$HOME/||" | \
			fzf --tmux
		)
		# Add home path back
		if [[ -n "$selected" ]]; then
			selected="$HOME/$selected"
		fi
	fi

	if [[ -z $selected ]]; then
		exit 0
	fi

	cd "$selected"
}
