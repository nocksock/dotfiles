export NVM_NO_USE=true
function nvm() {
  zgen load lukechilds/zsh-nvm
  nvm "$@"
}

