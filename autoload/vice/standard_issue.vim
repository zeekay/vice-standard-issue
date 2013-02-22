" Trim trailing whitespace from a file
func! vice#standard_issue#StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endf

func! vice#standard_issue#TransparencyToggle()
    if eval("&transparency") == 5
        let &transparency=0
    else
        let &transparency=5
    endif
endf

func! vice#standard_issue#DiffMapping()
    map <buffer> ]] :call search('^@@.*@@', 'w')<cr>zz
    map <buffer> [[ :call search('^@@.*@@', 'wb')<cr>zz
    map <buffer> u u :diffupdate!<cr>
    map <buffer> q :q<cr>
    " map <buffer> Q :qa<cr>
    " map <buffer> <leader>q :qa<cr>
    normal gg]]
endf
