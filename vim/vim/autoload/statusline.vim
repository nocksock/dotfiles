vim9script 

export def GitBranch(): string
    silent var branch = system('git rev-parse --abbrev-ref HEAD 2> /dev/null')
    branch = substitute(branch, '[[:cntrl:]]', '', 'g')

    if !branch->len()
        return 'no git'
    endif

    return  branch .. '  '
enddef
