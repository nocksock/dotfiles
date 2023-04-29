export NNN_BMS="c:$HOME/code/;d:$HOME/code/dotfiles;n:$HOME/code/dotfiles/nvim/;b:$HOME/code/bleepbloop.studio/"
export NNN_FCOLORS='00001e310000000000000000'
export NNN_PLUG='o:!open $nnn;p:preview-tui;v:viu;x:!chmod +x $nnn'

alias nnn='nnn -ei'

# n - quit nnn and cd to the selected dir
# makes navigating filesystems with nnn a breeze, when I'm not familiar with the
# layout of the directory.
# credit: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
n () { 
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

