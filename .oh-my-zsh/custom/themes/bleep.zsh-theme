# bleep theme
#
# check simple prompt escapes in `man zshmisc` for escapes
# and `spectrum_ls` for colors

function zsh_bleep_gitstatus {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	GIT_STATUS=$(git_prompt_status)

	if [[ -n $GIT_STATUS ]]; then
		GIT_STATUS="%{$FG[241]%} $GIT_STATUS"
	fi

	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[241]%} %{$FG[231]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_UNTRACKED="u"
ZSH_THEME_GIT_PROMPT_ADDED="a"
ZSH_THEME_GIT_PROMPT_MODIFIED="m"
ZSH_THEME_GIT_PROMPT_RENAMED="r"
ZSH_THEME_GIT_PROMPT_DELETED="d"
ZSH_THEME_GIT_PROMPT_UNMERGED="c"


PROMPT=$'\n'
PROMPT+=" %{$FG[189]%}%~ %{$reset_color%}$(zsh_bleep_gitstatus)"
PROMPT+=$'\n'
PROMPT+="%(?:%{$FG[241]%}➜ :%{$FG[196]%}➜ )%{$reset_color%}"

