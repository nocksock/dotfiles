# standardized handling of $0
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# [[ -z ${FPATH[(r)${0:h}/functions]} ]] && fpath+=( "${0:h}/functions" )
[[ -z ${PATH[(r)${0:h}/bin]} ]] && path+=( "${0:h}/bin" )

# autoload -Uz ${0:h}/functions/*(:t)

alias gss='git status'
alias gs='git status -s .'
alias ngs='nvim +:Git status'
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
alias gg='lazygit'
alias gsw='pushd "$(git worktree list --porcelain | ggrep -Po "(?<=worktree ).*" | fzf)"'
alias gb="git branch -l --format='%(refname:short)' | fzf | xargs git switch" 
alias ggl='git-grouped-log'
alias gsb='git-switch-branch'
alias gpf='git push --force-with-lease'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias glex='git-log-explorer'

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "WIP [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "WIP " && git reset HEAD~1'

function gunwipall() {
  local _commit=$(git log --grep='WIP' --invert-grep --max-count=1 --format=format:%H)
  if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
    git reset $_commit || return 1
  fi
}

function gcm() {
	git commit -m "$*"
}

export PATH
export FPATH
