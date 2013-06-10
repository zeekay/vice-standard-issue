" Trim trailing whitespace from a file
func! vice#standard_issue#strip_trailing_whitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endf

func! vice#standard_issue#transparency_toggle()
    if eval("&transparency") == 5
        let &transparency=0
    else
        let &transparency=5
    endif
endf

func! vice#standard_issue#diff_close()
    windo if &diff || &ft == 'diff' | q | endif
endf

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

func! vice#standard_issue#indent_obj(inner)
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
  let i = i < 0 ? 0 : i
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
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
            NoMatchParen
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
