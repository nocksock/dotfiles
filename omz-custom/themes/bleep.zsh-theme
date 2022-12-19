# bleep theme
#
# check simple prompt escapes in `man zshmisc` for escapes
# and `spectrum_ls` for colors

function zsh_bleep_gitstatus {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	GIT_STATUS=$(git_prompt_status)

	if [[ -n $GIT_STATUS ]]; then
		GIT_STATUS="$fg[red] $GIT_STATUS"
	fi

	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="$reset_color "
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color "
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]✗"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[blue] "
ZSH_THEME_GIT_PROMPT_UNTRACKED="$fg[magenta]u"
ZSH_THEME_GIT_PROMPT_ADDED="$fg[green]a"
ZSH_THEME_GIT_PROMPT_MODIFIED="$fg[yellow]m"
ZSH_THEME_GIT_PROMPT_RENAMED="$fg[yellow]r"
ZSH_THEME_GIT_PROMPT_DELETED="$fg[yellow]d"
ZSH_THEME_GIT_PROMPT_UNMERGED="$fg[red]c"

function zsh_bleep_hostname {
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		echo "ssh://$USER@$HOST:"
	fi
}

PROMPT=$'\n'
PROMPT+='%{$fg[magenta]%}$(zsh_bleep_hostname)%{$fg[cyan]%}%~ %{$reset_color%}$(zsh_bleep_gitstatus)'
PROMPT+=$'\n'
PROMPT+='%(?:%{$fg[cyan]%}➜ :%{$fg[red]%}➜ )%{$reset_color%}'

