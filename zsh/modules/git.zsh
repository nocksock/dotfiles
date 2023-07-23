alias gss='git status -s .'
alias gs='vim +:Git status'
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
alias gg='lazygit'
alias gsw='pushd "$(git worktree list --porcelain | ggrep -Po "(?<=worktree ).*" | fzf)"'
alias glog='git-log-explorer'

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
