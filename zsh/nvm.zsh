export NVM_NO_USE=true
export NVM_LOADED=false

function nvm() {
  if [ "$NVM_LOADED" = false ]; then
    if [ -s $HOME/.nvm/nvm.sh ]; then
      . $HOME/.nvm/nvm.sh # This loads NVM
      NVM_LOADED=true
    fi
  fi

  nvm "$@"
}

