call vice#Extend({
    \ 'addons': [
        \ 'github:coderifous/textobj-word-column.vim',
        \ 'github:tpope/vim-commentary',
        \ 'github:tpope/vim-eunuch',
        \ 'github:tpope/vim-repeat',
        \ 'github:tpope/vim-surround',
        \ 'github:zeekay/vim-space',
    \ ],
    \ 'ft_addons': {
        \ 'html\|xhtml\|xml': [
            \ 'github:gregsexton/MatchTag',
        \ ],
        \ 'help': [
            \ 'github:juanpabloaj/help.vim',
        \ ],
    \ },
    \ 'commands': {
        \ 'Ack': ['github:mileszs/ack.vim'],
    \ }
\ })

let s:dir = expand('<sfile>:p:h')

" Basic/General Configuration {{{
    exe 'set backupdir='.s:dir.'/tmp/backup'
    set backup
    set noswapfile
    exe 'set viewdir='.s:dir.'/tmp/view'
    let &viminfo="'100,\"100,:100,h,n".s:dir.'/tmp/viminfo'
    set history=1000
    set backspace=indent,eol,start
    set matchpairs+=<:>
    set shortmess=aoOsTI
    set hidden
    set confirm
    silent! set fileformat=unix
    set encoding=utf-8
    set termencoding=utf-8
    set ruler
    set linebreak
    set nowrap
    set whichwrap=b,s,h,l,<,>,[,]
    set autoread
    set report=0
    set gdefault
    set showcmd
    set noshowmode
    set virtualedit=block,onemore
    set switchbuf=usetab
    set splitright
    set nomore
    set nrformats=hex,octal,alpha
    set clipboard=unnamed,unnamedplus
    silent! set breakindent
" }}}

" Indent {{{
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set smarttab
    set autoindent
    set copyindent
    set smartindent
    au FileType xml,xhtml,htmldjango setl shiftwidth=4
    au FileType css,html,coffee,haml,stylus,jade,javascript setl shiftwidth=2
" }}}

" Search/Highlight {{{
    set showmatch
    set incsearch
    set ignorecase
" }}}

" Menu/Complete {{{
    set completeopt=menuone,menu,longest
    set wildmenu
    set wildmode=list:longest,full
    set wildignore+=*.DS_Store " OSX bullshit
    set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
    set wildignore+=*.luac " Lua byte code
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
    set wildignore+=*.orig " Merge resolution files
    set wildignore+=*.pyc,*.pyo " Python byte code
    set wildignore+=*.spl " compiled spelling word lists
    set wildignore+=*.sw?  " Vim swap files
    set wildignore+=*/.svn/* " SVN Version control - Linux/MacOSX
    set wildignore+=.svn\* " SVN Version control - Windows
    set wildignore+=classes " Clojure/leiningen
    set wildignore+=migrations " Django migrations
    set wildignore+=*.zwc,*.zwc.old " ZSH
" }}}

" Enable omnicomplete {{{
    au FileType c setl omnifunc=ccomplete#Complete
    au FileType coffee,javascript setl omnifunc=javascriptcomplete#CompleteJS
    au FileType css setl omnifunc=csscomplete#CompleteCSS
    au FileType php setl omnifunc=phpcomplete#CompletePHP
    au FileType python setl omnifunc=pythoncomplete#Complete
    au FileType ruby,eruby setl omnifunc=rubycomplete#Complete
    au FileType xhtml,html setl omnifunc=htmlcomplete#CompleteTags
    au FileType xml setl omnifunc=xmlcomplete#CompleteTags
" }}}

" Detect filetypes {{{
    au BufNewFile,BufRead *.as set filetype=actionscript
    au BufNewFile,BufRead *.clj set filetype=clojure
    au BufNewFile,BufRead *.coffee,Cakefile set filetype=coffee
    au BufNewFile,BufRead *.go set filetype=go
    au BufNewFile,BufRead *.haml set filetype=haml
    au BufNewFile,BufRead *.jade set filetype=jade
    au BufNewFile,BufRead *.json set filetype=json
    au BufNewFile,BufRead *.sass set filetype=sass
    au BufNewFile,BufRead *.scss set filetype=scss
    au BufNewFile,BufRead *.styl set filetype=stylus
    au BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown
" }}}

" Console {{{
    if !has('gui_running')
        set ttyfast
        set t_Co=256
    endif
" }}}

" Gui {{{
    if has('gui_running')
        set guioptions=ace
        set fillchars=diff:⣿
        set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
    endif
" }}}

" MacVim {{{
    if has("gui_running") && has('mac')
        set macmeta
        set fuoptions=maxvert,maxhorz
        let g:macvim_hig_shift_movement = 1
        let g:macvim_skip_cmd_opt_movement = 1
        set guifont=Inconsolata-dz:h12
        set linespace=-1
        nnoremap <D-1> 1gt
        nnoremap <D-1> 1gt
        nnoremap <D-2> 2gt
        nnoremap <D-3> 3gt
        nnoremap <D-4> 4gt
        nnoremap <D-5> 5gt
        nnoremap <D-6> 6gt
        nnoremap <D-7> 7gt
        nnoremap <D-8> 8gt
        nnoremap <D-9> 9gt
        nnoremap <D-0> 10gt
        nnoremap <D-d> :vsplit<cr>
        nnoremap <D-D> :split<cr>
        nnoremap <D-[> <c-w>W
        nnoremap <D-]> <c-w>w
        nnoremap <D-CR> :set fullscreen!<cr>

        inoremap <D-1> <esc>1gt
        inoremap <D-2> <esc>2gt
        inoremap <D-3> <esc>3gt
        inoremap <D-4> <esc>4gt
        inoremap <D-5> <esc>5gt
        inoremap <D-6> <esc>6gt
        inoremap <D-7> <esc>7gt
        inoremap <D-8> <esc>8gt
        inoremap <D-9> <esc>9gt
        inoremap <D-0> <esc>10gt
        inoremap <D-d> <esc>:vsplit<cr>
        inoremap <D-D> <esc>:split<cr>
        inoremap <D-[> <esc><c-w>W
        inoremap <D-]> <esc><c-w>w
        inoremap <D-CR> <c-o>:set fullscreen!<cr>

        set transparency=5
        nnoremap <D-u> :call vice#standard_issue#transparency_toggle()<cr>
    endif
" }}}

" Linux gVim {{{
    if has('gui_running') && !has('mac') && !has('win32') && !has('win64')
        set guifont=DejaVu\ Sans\ Mono\ 8
    endif
" }}}

" Windows gVim {{{
    if has('gui_running') && has('win32') || has('win64')
        set guifont=Consolas
        cd ~
    endif
" }}}

" Statusline {{{
    set laststatus=2
    set statusline=\(%n\)\ %f\ %*%#Modified#%m\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]
" }}}

" Netrw {{{
    let g:netrw_silent = 1
    let g:netrw_cursor = 0
    let g:netrw_banner = 0
    let g:netrw_liststyle = 1
    let g:netrw_list_hide='\.swp$,\.pyc$,\.pyo$,^\.hg$,^\$,^\.svn$,^\.o$,.Trash,.DS_Store,.CFUserTextEncoding'
" }}}

" Ack.vim {{{
    let g:ackprg = "ack -i -H --nocolor --nogroup --column"
    nnoremap <leader>a :Ack!<space>
" }}}

" Commentary {{{
    au FileType cfg set commentstring=#\ %s
    au FileType cpp set commentstring=/\/\ %s
    au FileType python set commentstring=#\ %s
    au FileType lisp set commentstring=;;\ %s
    au FileType json set commentstring=/\/\ %s
" }}}

" Fast Escape {{{
    augroup fastescape
        au!
        set notimeout
        set ttimeout
        set timeoutlen=10
        au InsertEnter * set timeout
        au InsertLeave * set notimeout
    augroup END
" }}}

" Remove Trailing Whitespace {{{
    au FileType * au BufWritePre <buffer> :silent! call vice#standard_issue#strip_trailing_whitespace()
" }}}

" Mappings {{{
    if exists('g:disable_arrow_keys') && g:disable_arrow_keys
        " No arrow keys
        map <Left> :echo<cr>
        map <Right> :echo<cr>
        map <Up> :echo<cr>
        map <Down> :echo<cr>
        imap <Left> <c-o>:echo<cr>
        imap <Right> <c-o>:echo<cr>
        imap <Up> <c-o>:echo<cr>
        imap <Down> <c-o>:echo<cr>
        map OD :echo<cr>
        map OC :echo<cr>
        map OA :echo<cr>
        map OB :echo<cr>
        imap OD <c-o>:echo<cr>
        imap OC <c-o>:echo<cr>
        imap OA <c-o>:echo<cr>
        imap OB <c-o>:echo<cr>
    endif

    " Stay in visual mode after indentation change
    vnoremap > >gv
    vnoremap < <gv
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

    " Cmdline
    cnoremap <c-a> <Home>
    cnoremap <c-e> <End>
    cnoremap <c-h> <Left>
    cnoremap <c-j> <Down>
    cnoremap <c-k> <Up>
    cnoremap <c-l> <Right>

    " Paste in visual mode without yanking replaced text
    vnoremap p "_dP

    " Ctrl-h/l to switch between tabs
    nnoremap <c-h> :tabp<CR>
    nnoremap <c-l> :tabn<CR>

    " Ctrl-j/k to switch between buffers
    nnoremap <c-k> :bn<cr>
    nnoremap <c-j> :bp<cr>

    " Make pageup/pagedown move up/down half pages
    nnoremap <silent> <PageUp> <c-u><c-u>
    vnoremap <silent> <PageUp> <c-u><c-u>
    inoremap <silent> <PageUp> <c-\><c-o><c-u><c-\><c-o><c-u>

    nnoremap <silent> <PageDown> <c-d><c-d>
    vnoremap <silent> <PageDown> <c-d><c-d>
    inoremap <silent> <PageDown> <c-\><c-o><c-d><c-\><c-o><c-d>

    inoremap <silent> <c-f> <c-o><c-f>
    inoremap <silent> <c-b> <c-o><c-b>

    vnoremap <silent> <c-f> <c-f>
    vnoremap <silent> <c-b> <c-b>

    " Buffer mappings {{{
    nnoremap <silent> <Leader>d :bd<CR>

    " Wincmd mappings
    inoremap <c-w> <c-o><c-w>
    nnoremap <leader>w= <c-w>=
    nnoremap <leader>w+ <c-w>+
    nnoremap <leader>w- <c-w>-
    nnoremap <leader>w> <c-w>>
    nnoremap <leader>w< <c-w><
    nnoremap <leader>wh <c-w>h
    nnoremap <leader>wj <c-w>j
    nnoremap <leader>wk <c-w>k
    nnoremap <leader>wl <c-w>l
    nnoremap <leader>wH <c-w>H
    nnoremap <leader>wJ <c-w>J
    nnoremap <leader>wK <c-w>K
    nnoremap <leader>wL <c-w>L
    nnoremap <leader>wP <c-w>P
    nnoremap <leader>wR <c-w>R
    nnoremap <leader>wT <c-w>T
    nnoremap <leader>wb <c-w>b
    nnoremap <leader>wc <c-w>c
    nnoremap <leader>wn <c-w>n
    nnoremap <leader>wo <c-w>o
    nnoremap <leader>wp <c-w>p
    nnoremap <leader>wq <c-w>q
    nnoremap <leader>wr <c-w>r
    nnoremap <leader>wr <c-w>r
    nnoremap <leader>ws <c-w>s
    nnoremap <leader>wt <c-w>t
    nnoremap <leader>wv <c-w>v
    nnoremap <leader>ww <c-w>w
    nnoremap <leader>wx <c-w>x

    " blackhole register
    nnoremap <leader>b "_

    " Fast window moving/resizing with alt/meta
    if has('gui_running')
        nnoremap <M-J> <C-w>J
        nnoremap <M-K> <C-w>K
        nnoremap <M-H> <C-w>H
        nnoremap <M-L> <C-w>L

        inoremap <M-J> <Esc><C-w>J
        inoremap <M-K> <Esc><C-w>K
        inoremap <M-H> <Esc><C-w>H
        inoremap <M-L> <Esc><C-w>L

        nnoremap <M-j> <C-w>j
        nnoremap <M-k> <C-w>k
        nnoremap <M-h> <C-w>h
        nnoremap <M-l> <C-w>l

        inoremap <M-j> <Esc><C-w>j
        inoremap <M-k> <Esc><C-w>k
        inoremap <M-h> <Esc><C-w>h
        inoremap <M-l> <Esc><C-w>l

        nnoremap <M-=> <C-w>+
        nnoremap <M--> <C-w>-
        nnoremap <M->> <C-w>>
        nnoremap <M-<> <C-w><

        inoremap <M-=> <Esc><C-w>+
        inoremap <M--> <Esc><C-w>-
        inoremap <M->> <Esc><C-w>>
        inoremap <M-<> <Esc><C-w><
    else
        nnoremap h <c-w>h
        nnoremap j <c-w>j
        nnoremap k <c-w>k
        nnoremap l <c-w>l

        inoremap h <esc><c-w>h
        inoremap j <esc><c-w>j
        inoremap k <esc><c-w>k
        inoremap l <esc><c-w>l

        nnoremap H <c-w>H
        nnoremap J <c-w>J
        nnoremap K <c-w>K
        nnoremap L <c-w>L

        inoremap H <esc><c-w>H
        inoremap J <esc><c-w>J
        inoremap K <esc><c-w>K
        inoremap L <esc><c-w>L

        nnoremap = <c-w>+
        nnoremap - <c-w>-
        nnoremap > <c-w>>
        nnoremap < <c-w><

        inoremap = <c-o><c-w>+
        inoremap - <c-o><c-w>-
        inoremap > <c-o><c-w>>
        inoremap < <c-o><c-w><
    endif

    " Fast substitute
    nnoremap <leader>s :s\v%//<left>
    vnoremap <leader>s :s\v//<left>

    " Open in browser
    nnoremap <leader>of :py import webbrowser; webbrowser.open(<c-r>='"'.'file://'.expand('%:p').'"'<cr>)<cr>
    nnoremap <leader>ow :py import webbrowser; webbrowser.open(<c-r>='"'.expand("<cWORD>").'"'<cr>)<cr>

    " Identify vim syntax highlight group under cursor
    map <leader>hi :echo "hi: " . synIDattr(synID(line("."), col("."), 1), "name") . ", trans: "
                              \ . synIDattr(synID(line("."), col("."), 0), "name") . ", lo: "
                              \ . synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<CR>
    " toggle hlsearch
    map <leader>hl :set hls!<cr>

    if has('gui_running')
        " Close buffer only in GUI vim
        nnoremap Q :bd<cr>
    else
        " Close and quit if in terminal
        nnoremap Q :q<cr>
    endif

    " Indent text object mappings
    onoremap <silent>aI :<C-U>call vice#standard_issue#indent_obj(0)<CR>
    onoremap <silent>iI :<C-U>call vice#standard_issue#indent_obj(1)<CR>
    vnoremap <silent>aI :<C-U>call vice#standard_issue#indent_obj(0)<CR><Esc>gv
    vnoremap <silent>iI :<C-U>call vice#standard_issue#indent_obj(1)<CR><Esc>gv
    onoremap <silent>ai :<C-U>call vice#standard_issue#indent_obj_inc_blank(0)<CR>
    onoremap <silent>ii :<C-U>call vice#standard_issue#indent_obj_inc_blank(1)<CR>
    vnoremap <silent>ai :<C-U>call vice#standard_issue#indent_obj_inc_blank(0)<CR><Esc>gv
    vnoremap <silent>ii :<C-U>call vice#standard_issue#indent_obj_inc_blank(1)<CR><Esc>gv
" }}}

" Gitcommit {{{
    au FileType gitcommit call vice#standard_issue#git_commit()
" }}}

" Diff {{{
    set diffopt+=iwhite,context:3
    au FileType diff call vice#standard_issue#diff_mapping()
    au FilterWritePre * if &diff | call vice#standard_issue#diff_mapping() | endif
" }}}

" Quickfix / location list {{{
    au QuickFixCmdPost *grep* cwindow
    au FileType qf setl nolist
    au FileType qf setl nocursorline
    au FileType qf setl nowrap
    nnoremap ]q :cnext<cr>
    nnoremap [q :cprevious<cr>
    nnoremap ]Q :clast<cr>
    nnoremap [Q :cfirst<cr>
    nnoremap ]l :lnext<cr>
    nnoremap [l :lprevious<cr>
    nnoremap ]L :llast<cr>
    nnoremap [L :lfirst<cr>
" }}}

" Hax {{{
    " prevent changing read-only file warnings.
    au FileChangedRO * setl noro
" }}}

" vim: fdm=marker foldlevel=1 nofoldenable
