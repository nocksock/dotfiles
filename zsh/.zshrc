# vim:foldmethod=marker:foldlevel=0

# zmodload zsh/zprof # profile startup time

export TERM=xterm-kitty
export EDITOR=nvim
# export PAGER="nvim +Man! -R"
# export MANPAGER='nvim +Man!'
export HOMEBREW_NO_AUTO_UPDATE=1
export SBOX_DIR="$HOME/code/sandboxes/"
export SBOX_PATHS=(
	"$HOME/code/sandboxes"
	"$HOME/code/bleepbloop.git/main/packages"
	"$HOME/code/bleepbloop.git/main/apps"
)

# {{{ compinit

autoload -Uz compinit
autoload -U +X bashcompinit && bashcompinit

if [[ ! -f ~/.zcompdump ]] ; then
  compinit
	bashcompinit
	compdump
	echo "refreshed completions"
else
	compinit -C
	bashcompinit -C
fi

# brew completions {{{ 

if [[ -n `command -v brew` ]]; then
COMPLETION_DIRS=(
	"$(brew --prefix)/share/zsh/site-functions"
)
fi

for compdir in "${COMPLETION_DIRS[@]}"; do
	fpath+=("$compdir")
	autoload -Uz "$compdir"
done

# }}}
# {{{ 1password completion

if [[ -n `command -v op` ]]; then
	eval "$(op completion zsh)"
	compdef _op op
fi 

# }}}

# }}}
# {{{ keybinds

function _fg() {
	if [[ $(jobs | wc -l) -gt 0 ]]; then
		fg
	else
		tm-select
	fi
}

function _glow() {
	if [[ -n `command -v glow` ]]; then
		glow
	else
		echo "glow not installed"
	fi
}

function _cp-last() {
	echo !! | pbcopy
}

autoload -U edit-command-line
autoload -U select-word-style
zle -N edit-command-line # Emacs style
zle -N tm-p
zle -N _fg
zle -N _glow
zle -N _cp-last 
bindkey -e                       # use emacs keybindings
bindkey '^f' edit-command-line #  like nvim command-mode
bindkey "^[" vi-cmd-mode         # use esc to enter vi-cmd-mode
bindkey "\e[15~" _glow         # use esc to enter vi-cmd-mode
bindkey "^g" _cp-last
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M emacs '^Z' _fg
bindkey -M emacs '^S' tm-s
bindkey -M emacs '^J' accept-and-hold
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export WORDCHARS="*?_.[]~!#$%^(){}<>" # removed =/&;.-

# }}}
# switch from bar to block depending on input mode {{{

set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

# }}}
# {{{ history settings
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

export HISTFILE=~/.zsh_history
export HISTSIZE=999999
export SAVEHIST=999999
# }}}
# {{{ CDPATH

declare -U CDPATH cdpath
cdpath=(
	"$HOME"
	"$HOME/code"
	"$HOME/code/bleepbloop.git/main/apps"
	"$cdpath[@]"
)
export CDPATH

# }}}
# {{{ NNN

export NNN_BMS="c:$HOME/code/;d:$HOME/code/dotfiles;n:$HOME/code/dotfiles/;b:$HOME/code/bleepbloop.studio/"
export NNN_FCOLORS='00001e310000000000000000'
export NNN_PLUG='o:!open $nnn;p:preview-tui;v:viu;x:!chmod +x $nnn'
export NNN_FIFO=/tmp/nnn.fifo

# }}}

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

if [[ -n $KITTY_PID ]]; then
	alias ssh="kitty +kitten ssh"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [[ -s "$DOTLOG" ]]; then
	echo "There are log messages in $DOTLOG"
fi

# things that must not be in git
if [[ -f "$HOME/.zsh_secrets" ]]; then
	source "$HOME/.zsh_secrets"
fi

# zprof # show profiling result

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/nilsriedemann/.cache/lm-studio/bin"
# End of LM Studio CLI section


# Added by microsandbox installer
export PATH="$HOME/.local/bin:$PATH"
export DYLD_LIBRARY_PATH="$HOME/.local/lib:$DYLD_LIBRARY_PATH"
