alias gss='git status -s'
alias gs='vim +:Git status'
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'

alias gsw='git-select-worktree'
function git-select-worktree () {
  local selected_worktree=$(git worktree list --porcelain | grep -Po "(?<=worktree ).*" | fzf)
  cd "$selected_worktree"
}

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
alias gsb='git-select-branch'
git-select-branch () {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m)
  if [[ "$branch" == "" ]]; then
    echo "No branch selected"
    return
  fi
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# git-show-commit: find a commit via fzf and show its contents. Pressing q will
# return to fzf
alias gsc='git-show-commit'
git-show-commit () {
  git log          \
    --graph        \
    --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@"\
    | fzf                       \
      --ansi                    \
      --no-sort                 \
      --reverse                 \
      --tiebreak=index          \
      --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
        (grep -o '[a-f0-9]\{7\}' | head -1 |
          xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
}


