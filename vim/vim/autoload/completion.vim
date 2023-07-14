vim9script
# source: https://git.sr.ht/~derhans/vimrc/tree/main/item/autoload/completion.vim

export def Disable()
    augroup compl
        autocmd!
    augroup END
enddef

export def Enable()
    Disable()

    augroup compl
        autocmd!
        autocmd InsertCharPre * Completion()
    augroup END
enddef

def SufficientChars(vchar: string, line: string, coln: number): number
    if vchar !~ '\K' || coln < 3
        return 0
    endif

    if coln == 4 && line[0 : 3] =~ '\K'
        return 1
    endif

    if coln > 4
        if line[coln - 5] !~ '\K'
            && line[coln - 4] =~ '\K'
            && line[coln - 3] =~ '\K'
            && line[coln - 2] =~ '\K'
            && line[coln - 1] !~ '\K'
            return 1
        endif
    endif

    return 0
enddef

def Completion()
    if pumvisible() || &paste
        return
    endif

    var line = getline('.')
    var coln = col('.')
    var sufficientChars = SufficientChars(v:char, line, coln)

    if &filetype == 'tex'
        if v:char == '\' || line[coln - 2] == '\' ||
           v:char == '{' || line[coln - 2] == '{'
            feedkeys("\<C-X>\<C-O>", 'n')
        elseif sufficientChars
            feedkeys("\<C-P>", 'n')
        endif
    elseif &filetype == 'python'
        if v:char == '.' || sufficientChars
            feedkeys("\<C-P>", 'n')
        endif
    else
        if sufficientChars
            feedkeys("\<C-P>", 'n')
        endif
    endif
enddef
