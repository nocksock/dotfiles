# # Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bleep"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode disabled  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew aliases dash fzf gh npm nvm tmux golang)
export NVM_AUTOLOAD=1

# User configuration

export EDITOR='/usr/local/bin/nvim' # used for commits and such
export TERM='xterm-kitty'
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export DOTDIR="$HOME/code/dotfiles"
export PYENV_ROOT="$HOME/.pyenv"

export BUN_INSTALL="/Users/nilsriedemann/.bun"

export PATH="/usr/local/bin:$PATH" # some apps put there stuff here (eg vscode, mullvad)
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/bin/gh/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="$DOTDIR/bin/:$PATH"
export PATH="$PYENV_ROOT/bin/:$PATH"
export PATH="/usr/local/cuda-11.6/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"

export LD_LIBRARY_PATH="/usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH"
export CDPATH=".:$HOME:$HOME/projects:$HOME/code"

# PyEnv, but not doing any python atm
eval "$(pyenv init --path)"

# changing the default command to ignore vcs, git, node_modules etcp
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZSH_CUSTOM=$DOTDIR/omz-custom

source $ZSH/oh-my-zsh.sh
source $DOTDIR/zsh/aliases.zsh
source $DOTDIR/zsh/moar_colors.zsh

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=90000              # How many lines of history to keep in memory
HISTFILE=~/.zsh_history     # Where to save history to disk
SAVEHIST=90000              # Number of history entries to save to disk
HISTDUP=erase               # Erase duplicates in the history file
setopt    appendhistory     # Append history to the history file (no overwriting)
setopt    sharehistory      # Share history across terminals
setopt    incappendhistory  # Immediately append to the history file, not just when a term is killed

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NNN_BMS="c:$HOME/.config/;f:$HOME/forks;p:$HOME/projects/;b:$HOME/projects/bleepbloop.studio/;e:$HOME/projects/edeka-de/"
export NNN_FCOLORS='00001e310000000000000000'
export NNN_PLUG='o:!open $nnn;p:preview-tui;v:viu;x:!chmod +x $nnn'
export NNN_FIFO=/tmp/nnn.fifo

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# bun completions
[ -s "/Users/nilsriedemann/.bun/_bun" ] && source "/Users/nilsriedemann/.bun/_bun"
