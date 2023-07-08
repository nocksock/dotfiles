# Enable aliases to be sudo’ed
#    http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

alias reload="source ~/.zshrc; rehash"

# ls
alias ls='exa --icons -1 --group-directories-first -a'
alias ll='exa --icons -l --group-directories-first -a'

# navigation
alias c='cd $(list-projects | fzf)'
alias ..='cd ..'
alias q='cd ~ && clear'

function take() {
	mkdir -p $1
	cd $1
}

# apps
alias tf=terraform
alias love='open -n -a love'

# Avoid rm mistakes with trash-cli:
# 	https://github.com/sindresorhus/trash-cli
if type trash &>/dev/null; then
	alias rm='trash' # move to trash instead of delete
else
	alias rm='rm -i' # rm -i will ask for each deletion
fi

