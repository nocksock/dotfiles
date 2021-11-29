# changing the default command to ignore vcs, git, node_modules etcp
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,node_modules.*/,.git/*,package-lock.json}"'
