function zsh_bleep_hostname {
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		echo "ssh://$USER@$HOST:"
  else
    echo "local"
	fi
}

function zsh_bleep_gitstatus {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	GIT_STATUS=$(git_prompt_status)

	if [[ -n $GIT_STATUS ]]; then
		GIT_STATUS="$fg[red] $GIT_STATUS"
	fi

	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

