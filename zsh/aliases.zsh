# Enable aliases to be sudo’ed
#    http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias -g G='| grep'

alias -g L='| less'
alias ..='cd ..'

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
# gbr: git branches fuzzy finder {{{
gbr() {
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

# ts [FUZZY PATTERN] - Select selected tmux session{{{
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
function ts() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}
# }}}
