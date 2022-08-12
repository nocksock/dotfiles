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

# sometimes I might want to append to a path of some other function,
# this way I don't have to remember sed syntax - and deal with escaping of
# slashes.
# eg.:
#     $ npm get prefix | append /bin
#     /Users/the-user/.nvm/versions/node/v16.7.0/bin
append()
{
  sed "s/$/${1/\//\\/}/g"
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
	mkdir $1
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

# git-log-by-day: Generates git changelog grouped by day {{{
# optional parameters
# -a, --author       to filter by author
# -s, --since        to select start date
# -u, --until        to select end date
git-log-by-day () {
  local NEXT=$(date +%F)

  local RED="\x1B[31m"
  local YELLOW="\x1B[32m"
  local BLUE="\x1B[34m"
  local RESET="\x1B[0m"

  local SINCE="1970-01-01"
  local UNTIL=$NEXT

  for i in "$@"
  do
  case $i in
    -a=*|--author=*)
    local AUTHOR="${i#*=}"
    shift
    ;;
    -s=*|--since=*)
    SINCE="${i#*=}"
    shift
    ;;
    -u=*|--until=*)
    UNTIL="${i#*=}"
    shift
    ;;
    *)
      # unknown option
    ;;
  esac
  done

  local LOG_FORMAT=" %Cgreen*%Creset %s"

  if [ -z "$AUTHOR" ]
  then
    LOG_FORMAT="$LOG_FORMAT %Cblue(%an)%Creset"
  else
    echo
    echo -e "${BLUE}Logs filtered by author: ${AUTHOR}${RESET}"
  fi

  git log --no-merges --author="${AUTHOR}" --since="${SINCE}" --until="${UNTIL}" --format="%cd" --date=short | sort -u | while read DATE ; do

    local GIT_PAGER=$(git log --no-merges --reverse --format="${LOG_FORMAT}" --since="${DATE} 00:00:00" --until="${DATE} 23:59:59" --author="${AUTHOR}")

    if [ ! -z "$GIT_PAGER" ]
    then
      echo
      echo -e "${RED}[$DATE]${RESET}"
      echo -e "${GIT_PAGER}"
    fi

  done
}
# }}}
