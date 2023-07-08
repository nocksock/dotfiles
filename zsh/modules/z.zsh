source $DOTDIR/zsh/modules/z/z.sh

zz () {
  cd $(z-select)
}

function z-select {
  echo $(
    z                  \
    | awk '{print $2}' \
    | sed "s#$HOME#~#" \
    | fzf              \
    | sed "s#~#$HOME#" \
  )
}
