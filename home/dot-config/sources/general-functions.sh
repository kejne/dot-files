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
	if [[ $# -ge 1 ]]; then
		selected=$(find ~/git/github.com/ ~/git/src/github.com -mindepth 1 -type d 2>/dev/null | \
			sed "s|^$HOME/||" | \
			fzf --filter "$(echo $@)" | head -1
		)
	else
		selected=$(find ~/git/github.com/ ~/git/src/github.com -mindepth 1 -type d 2>/dev/null | \
			sed "s|^$HOME/||" | \
			fzf --tmux
		)
	fi

	# Add home path back
	if [[ -n "$selected" ]]; then
		selected="$HOME/$selected"
	fi

	if [[ -z $selected ]]; then
		return
	fi

	cd "$selected"
}
