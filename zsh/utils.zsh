function zsh-bleep-hostname {
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		echo "ssh://$USER@$HOST:"
	fi
}

