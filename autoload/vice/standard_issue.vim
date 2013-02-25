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

func! vice#standard_issue#close_diff()
    windo if &diff || &ft == 'diff' | q | endif
endf

func! vice#standard_issue#DiffMapping()
    if &diff
        map <buffer> ]] ]c
        map <buffer> [[ [c
    else
        map <buffer> ]] :call search('^@@.*@@', 'w')<cr>zz
        map <buffer> [[ :call search('^@@.*@@', 'wb')<cr>zz
    endif
    map <buffer> u u :diffupdate!<cr>
    map <buffer> \q :call vice#standard_issue#close_diff()<cr>
    map <buffer> q :call vice#standard_issue#close_diff()<cr>
    map <buffer> Q :call vice#standard_issue#close_diff()<cr>
    " This is causes E855: Autocommands caused command to abort :(
    " au BufWinLeave <buffer> call vice#standard_issue#close_diff()
    normal gg]]
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
