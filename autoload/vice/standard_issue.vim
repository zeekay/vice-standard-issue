" Disable vim-signature on a given buffer.
func! vice#standard_issue#signature_disable()
    " Store signature setting if necessary
    let b:vice_sig_enabled = 0
    if exists('b:sig_enabled')
        let b:vice_sig_enabled = b:sig_enabled
        let b:sig_enabled = 0
    endif
endf

" Re-enable vim-signature
func! vice#standard_issue#signature_enable()
    " Restore vim-signature settings
    let b:sig_enabled = b:vice_sig_enabled
endf

" Trim trailing whitespace from a file
func! vice#standard_issue#strip_trailing_whitespace()
    call vice#standard_issue#signature_disable()

    " Set mark so we can restore our position
    normal mZ

    " Trim trailing whitespace
    %s/\s\+$//e

    " Restore position and clear mark
    normal `ZmZ

    call vice#standard_issue#signature_enable()
endf

" Toggle transparency
func! vice#standard_issue#transparency_toggle()
    if eval("&transparency") > 0
        set transparency=0
    else
        exe 'set transparency='.g:vice.standard_issue.transparency
    endif
endf

" Close diff
func! vice#standard_issue#diff_close()
    windo if &diff || &ft == 'diff' | q | endif
endf

" Quit only if in a normal buffer, otherwise close window.
func! vice#standard_issue#smart_quit()
    if &pvw
        pclose
    elseif &ft == 'qf'
        wincmd w
        try
            " Cannot close last window errors
            lclose
            cclose
        catch
            q
        endtry
    else
        q
    endif
endf

" Setup various keymaps for diff
func! vice#standard_issue#diff_mapping()
    if exists('b:diff_mapping')
        return
    else
        let b:diff_mapping = 1
    endif

    if &diff
        nnoremap <buffer> ]] ]c
        nnoremap <buffer> [[ [c
    else
        nnoremap <buffer> ]] :call search('^@@.*@@', 'w')<cr>zz
        nnoremap <buffer> [[ :call search('^@@.*@@', 'wb')<cr>zz
    endif

    nnoremap <buffer> [] <Nop>
    nnoremap <buffer> ][ <Nop>

    nnoremap <buffer> u u :diffupdate!<cr>
    nnoremap <buffer> \q :call vice#standard_issue#diff_close()<cr>
    nnoremap <buffer> q :call vice#standard_issue#diff_close()<cr>
    nnoremap <buffer> Q :call vice#standard_issue#diff_close()<cr>

    normal gg]c

    " Automatically update diff on changes
    augroup auto_diff_update
      au!
      autocmd InsertLeave * if &diff | diffupdate | let b:old_changedtick = b:changedtick | endif
      autocmd CursorHold *
            \ if &diff &&
            \    (!exists('b:old_changedtick') || b:old_changedtick != b:changedtick) |
            \   let b:old_changedtick = b:changedtick | diffupdate |
            \ endif
    augroup END
    nnoremap <silent> do do:let b:old_changedtick = b:changedtick<CR>
    nnoremap <silent> dp dp<C-W>w:if &modifiable && &diff \| let b:old_changedtick = b:changedtick \| endif<CR><C-W>p
endf

" Indent helpers
func! vice#standard_issue#indent_obj(inner)
    let curline = line('.')
    let lastline = line('$')
    let i = indent(line('.')) - &shiftwidth * (v:count1 - 1)
    let i = i < 0 ? 0 : i
    if getline('.') !~ '^\\s*$'
        let p = line('.') - 1
        let nextblank = getline(p) =~ '^\\s*$'
        while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
            -
            let p = line('.') - 1
            let nextblank = getline(p) =~ '^\\s*$'
        endwhile
        normal! 0V
        call cursor(curline, 0)
        let p = line('.') + 1
        let nextblank = getline(p) =~ '^\\s*$'
        while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
            +
            let p = line('.') + 1
            let nextblank = getline(p) =~ '^\\s*$'
        endwhile
        normal! $
    endif
endf

func! vice#standard_issue#indent_obj_inc_blank(inner)
    let curline = line(".")
    let lastline = line("$")
    let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
    let i = i < 0 ? 0 : i

    if getline(".") =~ "^\\s*$"
        return
    endif

    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"

    while p > 0 && (nextblank || indent(p) >= i )
        -
        let p = line(".") - 1
        let nextblank = getline(p) =~ "^\\s*$"
    endwhile

    if (!a:inner)
        -
    endif

    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"

    while p <= lastline && (nextblank || indent(p) >= i )
        +
        let p = line(".") + 1
        let nextblank = getline(p) =~ "^\\s*$"
    endwhile

    if (!a:inner)
        +
    endif

    normal! $
endf

" Detect long lines and disable various features which slow vim down
func! vice#standard_issue#detect_long_line()
    if exists('b:__vice_detect_long_line')
        return
    endif

    let b:__vice_detect_long_line = 1

    let original_line = line('.')

    let line = 1
    while line <= line("$")
        call cursor(line, 0)

        " Disable NeoComplcache and MatchParen when a long line is detected
        if col('$') > 2000
            silent! NeoComplCacheDisable
            silent! NoMatchParen
            call cursor(original_line, 0)
            echo "Long line detected! NeoComplCache and MatchParen disabled."
            return
        endif

        " Bail if file is exceptionally long to prevent delay in load times.
        if line > 2000
            call cursor(original_line, 0)
            return
        endif

        let line += 1
    endwhile

    call cursor(original_line, 0)
endf

" Toggle hex mode.
function vice#standard_issue#toggle_hex()
    " hex mode should be considered a read-only operation save values for
    " modified and read-only for restoration later, and clear the read-only flag
    " for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1

    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft

        if !b:oldbin
            setlocal nobinary
        endif

        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif

    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction
