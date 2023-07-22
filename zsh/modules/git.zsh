alias gss='git status -s .'
alias gs='vim +:Git status'
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
alias gg='lazygit'

alias gsw='git-select-worktree'
function git-select-worktree () {
  pushd "$(git worktree list --porcelain | grep -Po "(?<=worktree ).*" | fzf)"
}

alias glog='git-log-explorer'
function git-log-explorer {
  format="format:%C(yellow)%h%Creset %Cblue%as%Creset %Cred%<(20,trunc)%ae%Creset %s" 
  git log ${@}                                                \
    --decorate                                                \
    --color=always                                            \
    --pretty="$format"                                        \
    | fzf              \
        --ansi --no-sort --track                              \
        --preview="git show {1}"                              \
        --bind "ctrl-m:execute(zsh -c 'git show {1} | nvim -c \"set buftype=nofile\"')"
}

# copy autocomplete from git-log to git-log-explorer because all args are expanded to 
# git-log
function _git-log-explorer {
  _git log
}
compdef _git git-log-explorer=git-log

# git-grouped-log: show commits grouped by committer and date
alias ggl='git-grouped-log'
function git-grouped-log {
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
}

# git-select-branch: checkout a branch via fzf 
alias gsb='git-switch-branch'
git-switch-branch () {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m)
  if [[ "$branch" == "" ]]; then
    echo "No branch selected"
    return
  fi
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
