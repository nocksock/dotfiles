source $DOTDIR/zsh/modules/z/z.sh

function select-z {
  echo $(
    z                  \
    | awk '{print $2}' \
    | sed "s#$HOME#~#" \
    | fzf              \
    | sed "s#~#$HOME#" \
  )
}
