# Terminal Setup {{{
export EDITOR='/usr/local/bin/nvim' # used for commits and such
export TERM='xterm-kitty'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# }}}

export DOTDIR="$HOME/code/dotfiles"

export PATH="$PATH:/usr/local/bin" 
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/code/bleepbloop.git/main/bin"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$DOTDIR/bin/"
export PATH="$PATH:/usr/local/cuda-11.6/bin"
export PATH="$PATH:$BUN_INSTALL/bin"
export PATH="$PATH:/opt/homebrew/opt/grep/libexec/gnubin" 
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/opt/homebrew/opt/bison/bin"
export PATH="$PATH:$PNPM_HOME"

export PYENV_ROOT="$HOME/.pyenv"
export LD_LIBRARY_PATH="/usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# oh my zsh {{{
export ZSH_CUSTOM=$DOTDIR/omz-custom
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bleep"
zstyle ':omz:update' mode disabled  # just remind me to update when it's time
zstyle ':omz:update' frequency 13
plugins=(aliases npm yarn nvm fzf tmux z git)
source $ZSH/oh-my-zsh.sh
# }}}

for file in "$DOTDIR"/zsh/*.zsh "$DOTDIR"/bin/*_completion; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval "$(op completion zsh)"; compdef _op op
