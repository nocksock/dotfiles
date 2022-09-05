# {{{
if status --is-login
  set -g DOTDIR "$HOME/code/dotfiles"
  fish_add_path "/usr/local/bin:$PATH" # some apps put there stuff here (eg vscode, mullvad)
  fish_add_path "/opt/homebrew/bin:$PATH"
  fish_add_path "$HOME/bin:$PATH"
  fish_add_path "$HOME/go/bin:$PATH"
  fish_add_path "$HOME/.composer/vendor/bin:$PATH"
  fish_add_path "$HOME/.emacs.d/bin:$PATH"
  fish_add_path "$HOME/.poetry/bin:$PATH"
  fish_add_path "$PYENV_ROOT/bin/:$PATH"
  fish_add_path "/usr/local/cuda-11.6/bin:$PATH"
  fish_add_path "$BUN_INSTALL/bin:$PATH"
  fish_add_path "$DOTDIR/bin/:$PATH"
end
# }}}

set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_showdirtystate true 
set -g __fish_git_prompt_showdirtystate true 
set -g __fish_git_prompt_color brblack
set -g __fish_git_prompt_char_dirtystate
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_color_flags red yellow green blue

alias sudo='sudo '
alias ..='cd ..'
alias tower='open . -a Tower'
alias fh='history 1 | fzf'
alias nv=nvim
alias tf=terraform
alias nv=/usr/local/bin/nvim
alias p=tmux-qp
alias love='open -n -a love'
alias nnn='nnn -ei'
alias ls='exa --icons -1 --group-directories-first'
alias ll='exa --icons -l --group-directories-first'
alias reload='source ~/.config/fish/config.fish'

alias gl='git pull'
alias gsb='git status -sb'
alias gss='git status -s'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph --decorate --all'
alias glg="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glgs="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

# vi: fen fdm=marker fdl=0
