# Enable aliases to be sudo’ed
#    http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias -g G='| grep'
alias -g L='| less'
alias ..='cd ..'
alias tower='open . -a Tower'
alias fh='history 1 | fzf'
alias nv=nvim
alias tf=terraform
alias nv=/usr/local/bin/nvim
alias p=tmux-qp
alias love='open -n -a love'
alias nnn='nnn -ei'
alias c='cd $(list-projects | fzf)'
alias ls='exa --icons -1 --group-directories-first'
alias ll='exa --icons -l --group-directories-first'
alias gw='cd $(git worktree list --porcelain | grep -Po "(?<=worktree ).*" | gum filter)'
alias tml="tmux-live"
alias reload="source ~/.zshrc"

zz () {
  cd $(z | awk '{print $2}' | sed "s#$HOME#~#" | fzf | sed "s#~#$HOME#")
}

tz () {
  local dir=$(z | awk '{print $2}' | sed "s#$HOME#~#" | fzf | sed "s#~#$HOME#")
	tmux -u new -s ${dir##*/}
}

n () { # via https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
  if [[ "${NNNLVL:-0}" -ge 1 ]]; then
    echo "nnn is already running"
    return
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  \nnn -e "$@"

  if [ -f "$NNN_TMPFILE" ]; then
      . "$NNN_TMPFILE"
      rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

# Avoid rm mistakes  with trash-cli:
# 	https://github.com/sindresorhus/trash-cli
if type trash &>/dev/null; then
	alias rm='trash' # move to trash instead of delete
else
	alias rm='rm -i' # rm -i will ask for each deletion
fi

# ls
alias ll='ls -laF'
alias la='ls -A'
alias l='ls -CF'

# tmux
alias tat='tmux -u attach -t'
alias tmux="TERM=screen-256color-bce tmux"

# git
alias gss='git status -s'
alias gs='vim +:Git status'
alias o='open'
alias oo='open .'

alias q='cd ~ && clear'

function take() {
	mkdir -p $1
	cd $1
}

# gr: git roo; move to root of current rep
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'

function tmn() {
	tmux -u new -s ${PWD##*/}
}

function git-grouped-log () { # {{{
  while read -r -u 9 since name
  do
    until=$(date -j -v+1d -f '%Y-%m-%d' $since +%Y-%m-%d)

    echo "$since $name"
    echo

    GIT_PAGER=cat git log             \
      --no-merges                     \
      --committer="$name"             \
      --since="$since 00:00:00 +0000" \
      --until="$until 00:00:00 +0000" \
      --format='  * [%h] %s'

    echo
  done 9< <(git log --no-merges --format=$'%cd %cn' --date=short | sort --unique --reverse)
} # }}}

# fbr: fuzzy find branch {{{
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
} # }}}

# git show fuzzy filter {{{
gshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
} # }}}
