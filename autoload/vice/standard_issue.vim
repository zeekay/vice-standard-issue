" Trim trailing whitespace from a file
func! vice#standard_issue#StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endf

" Automatically show diff in git window
func! vice#standard_issue#CloseDiff()
    if bufwinnr(g:_commitnr) == -1
        unlet g:_commitnr
        q
    endif
endf

func! vice#standard_issue#GitCommit()
    " Disable automatic completion
    silent! NeoComplCacheLock

    " fugitive's Gstatus window is a preview window, we don't show the diff automatically there.
    " Through some magic I do not understand we can be called multiple
    " times, avoid that.
    if !eval('&pvw') && !exists('g:_commitnr')
        let g:_commitnr = bufnr('%')
        vnew
        silent! 0r!git diff --cached
        normal gg
        setl ft=diff
        setl readonly
        setl noswapfile
        setl nobuflisted
        setl buftype=nofile
        setl bufhidden=delete
        " Close if the diff is empty
        if line('$') == 1 && getline(1) == ''
            q
        else
            au WinEnter <buffer> call vice#standard_issue#CloseDiff()
            exe bufwinnr(g:_commitnr) . "wincmd w"
        endif
    endif
endf
