" @File              : .vimrc for ajcrites
set t_Co=256

call pathogen#infect()

set nocompatible     " Not like Vi
set autoread         " detect when file is changed
set ttyfast          " faster redraw
set nolazyredraw     " don't redraw when executing macros
set autoindent       " autoidentation on
set smartindent      " smartindentation on
set showmatch        " blink back to closing bracket (using % key)
set shell=$SHELL
set title            " terminal title
set background=dark  " highlighting depends on background color (dark or light)
set nowrapscan       " turn off search wrapping
set ignorecase       " ignore case in search
set smartcase        " consider case only when typing Uppercase
set hlsearch         " highlight search pattern
set noincsearch      " no incremental search
set vb t_vb=         " don't notify (no audio/visual bell)
set showmode         " display mode INSERT/REPLACE/...
set scrolloff=3      " dont let the curser get too close to the edge
set laststatus=2     " laststatus:  show status line?  Yes, always!
set nonumber         " no line numbers
set expandtab        " Expand Tabs (pressing Tab inserts spaces)
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set list listchars=tab:>-        " visual display of tabs
set complete+=k      " dictionary scanning
set bs=2             " backspace ???
set exrc
set secure
set nofoldenable     " folding is over!
retab                " force all Tab characters to match current Tab preferences
filetype plugin on   " idk what this does, but it seems important
syntax on            " Enable syntax highlighting
set omnifunc=syntaxcomplete#Complete

function s:EditFromJump( )
endfunction

autocmd FileType spec set filetype=xml
autocmd BufEnter *.less set filetype=css
autocmd BufEnter *.go set filetype=go
autocmd BufEnter *.zsh-theme set filetype=sh
autocmd BufEnter *.es6 set filetype=javascript
autocmd BufEnter *.es7 set filetype=javascript
autocmd BufEnter *.apib set filetype=markdown
autocmd BufEnter *.php set dictionary+=/home/ajcrites/.vim/bundle/vim-explosion-pills/phpfunctions.txt
autocmd BufEnter *.yml set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter *.go set noexpandtab
autocmd BufEnter *.hbs set filetype=html
autocmd BufEnter Jenkinsfile set filetype=groovy

autocmd BufEnter * set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter package.json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter project.json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter swagger.yaml set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter *.ts set softtabstop=2 tabstop=2 shiftwidth=2

" project-specific indentation
autocmd BufEnter ~/projects/mobq/kinvey/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/aliro-platform/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/knight/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/insulet/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/tcp/* set softtabstop=2 tabstop=2 shiftwidth=2

" autocmd BufWritePre *.js Neoformat

" Remember last line after opening file (from /etc/vim/vimrc
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

let g:vimsyn_folding='af'
let php_folding=2
let javaScript_fold=0

" In visual mode: TAB and Shift-TAB for indenting
vmap <TAB>     >
vmap <S-TAB>   <

" Insertion abbreviations
" Example: 04.09.00 - 09:53
iab YDT           <C-R>=strftime("%d.%m.%y - %H:%M")<CR>
" insert the current filename *without* path:
iab YFILE <C-R>=expand("%:t:r")<cr>

au BufReadPost *
\if line("'\"") > 0 |
\  if line("'\"") <= line("$") |
\     exe("norm '\"") |
\  else |
\     exe "norm $" |
\  endif |
\endif

function! PoundComment()
  map - :s/^/# /<CR>
  map _ :s/^\s*# \=//<CR>
  set comments=:#
endfunction

function! SlashComment()
  map - :s/^/\/\/ /<CR>        :nohlsearch<CR>
  map _ :s/^\s*\/\/ \=//<CR>   :nohlsearch<CR>
endfunction

"Write the opening and closing php tags to an empty file
function! WriteTags()
  if line("$") == 1
    call append(0, "<?php")
    call append(1, "?>")
  endif
endfunction

autocmd FileType perl       call PoundComment()
autocmd FileType sh         call PoundComment()
autocmd FileType py         call PoundComment()
autocmd FileType php        call SlashComment()
autocmd FileType php        call WriteTags()
autocmd FileType javascript call SlashComment()
autocmd FileType javascript nmap st :TernDoc<CR>
autocmd FileType java       call SlashComment()

colorscheme andy

highlight Badspace ctermfg=red ctermbg=red
au VimEnter,BufWinEnter * syn match Badspace /\s\+$/ containedin=ALL | hi link customBadWhitespace Error

"Quirky mappings
"
" Opposite of J -- split lines
nnoremap K i<CR><Esc>
" quickly delete and correctly indent current line
nnoremap do ddO
" replace current line with clipboard
nnoremap dp p<Up>dd
map , <PageDown>
map . <PageUp>
" <delete> key
nnoremap ' <Right>x
"Prevent pause on dd waiting for dt/df
noremap dd dd
noremap dt dt
noremap yy yy
noremap yt yt
noremap df df
noremap ct ct
" t to repeat command -- . is pgup
noremap t .
" vim directional bindings for window switching
map <C-w>h <C-w><Left>
map <C-w>j <C-w><Down>
map <C-w>k <C-w><Up>
map <C-w>l <C-w><Right>

" delete a function or a loop
map fd <Esc><Home>/{<Return><C-l>d%dd

" create matching braces
inoremap {{ {<Esc>o}<Up><Esc>o
inoremap [, [<Esc>o],<Up><Esc>o
inoremap {; {<Esc>o};<Up><Esc>o
inoremap {( {<Esc>o})<Up><Esc>o
inoremap (; {<Esc>o});<Up><Esc>o
inoremap {, {<Esc>o},<Up><Esc>o
inoremap 2{ {{}}<Left><Left>
inoremap {% {%%}<Left><Left>

" created matches for building arrays, functions, etc.
imap [' ['']<Left><Left>
imap [" [""]<Left><Left>

" <Esc> from the home row
imap ij <Esc>
vmap ij <Esc>

" insert newline in normal mode
map Z o<Esc>

" quick unhighlight after search
nnoremap <C-l> :nohl<CR>

" typos
abbr springf sprintf
abbr rlmNAme rlmName
abbr cousre course
abbr Cousre Course
abbr functino function
abbr functoin function
abbr funciton function
abbr funcion function
abbr multipe multiple
abbr Gliem Gleim
abbr breka break
abbr lenght length
abbr reutrn return
abbr retrun return

" syntax mistypes
imap <Br <br
imap codE> code>
imap 4_ $_
imap if( if<Space>(
imap $> %>

"make `-` a word character so I can autocomplete words containing dashes
function! DashToggle()
   echo &iskeyword
   if matchstr(&iskeyword, '-$') == '-'
      set iskeyword-=-
   else
      set iskeyword+=-
   endif
endfunction

" no shift key for command entering -- what does semicolon do??
noremap ; :
" s is common command mode
nmap sd :call DashToggle()<CR>
nmap sn :set nonumber!<CR>
nmap ss :set spell!<CR>
nmap sh <C-w>h
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l
nmap sg :Gstatus<CR>

" mouse (in tmux)
if !has('nvim')
    set ttymouse=xterm2
endif
set mouse=a

" Directories for swap files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" xml editing
let xml_tag_completion_map = "@"
inoremap ==" =""<Space><Left><Left>
inoremap ==' =''<Space><Left><Left>
inoremap =" =""<Left>
inoremap =' =''<Left>

set colorcolumn=80
autocmd BufEnter *.md set colorcolumn=60

" Gundo
nnoremap <F5> :GundoToggle<CR>

" jsx
let g:jsx_ext_required = 0

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.8)<cr>
nnoremap <silent> N   N:call HLNext(0.8)<cr>

" Blink match
function! HLNext (blinktime)
    highlight RedOnRed ctermfg=red ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    echo matchlen
    let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
            \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
            \ . '\|'
            \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+3).'v.'
            \ . '\|'
            \ . '\%'.(lnum+1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.'
    let ring = matchadd('RedOnRed', ring_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 50) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" Shift-tab moves backwards in popup menus
" function! Smart_TabNavigation()
"    if pumvisible()
"        return ""
"    endif
"    return "	"
"endfunction

"inoremap <s-tab> <c-r>=Smart_TabNavigation()<CR>

" let g:syntastic_javascript_checkers = ['tern_lint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = []
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:syntastic_rust_checkers = ['rustc']
let g:statline_syntastic = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" neovim plugins
if &compatible
    set nocompatible
endif
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/deoplete.nvim')
" call dein#add('mhartington/deoplete-typescript')
call dein#add('carlitux/deoplete-ternjs')
call dein#add('tweekmonster/nvim-checkhealth')
call dein#add('leafgarland/typescript-vim')
call dein#add('Quramy/vim-js-pretty-template')
call dein#add('jason0x43/vim-js-indent')
call dein#add('Quramy/tsuquyomi')
call dein#add('scrooloose/syntastic')
call dein#add('hashivim/vim-terraform')
call dein#add('rust-lang/rust.vim')
call dein#add('ElmCast/elm-vim')
call dein#add('chaoren/vim-wordmotion')
call dein#add('sbdchd/neoformat')
call dein#add('vim-scripts/SyntaxComplete')
call dein#add('mileszs/ack.vim')
call dein#add('ajcrites/autoswap-tmux')
call dein#add('kien/ctrlp.vim')
call dein#add('fatih/vim-go')
call dein#add('junegunn/goyo.vim')
call dein#add('sjl/gundo.vim')
call dein#add('neovimhaskell/haskell-vim')
call dein#add('tpope/vim-markdown')
call dein#add('tpope/vim-abolish')
call dein#add('vim-airline/vim-airline')
call dein#add('easymotion/vim-easymotion')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-fugitive')
call dein#add('othree/html5.vim')
call dein#add('elzr/vim-json')
call dein#add('moll/vim-node')
call dein#add('sickill/vim-pasta')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('mattn/webapi-vim')
call dein#add('ajcrites/xmledit')

call dein#end()

" let g:deoplete#disable_auto_complete = 1
" let g:deoplete#enable_at_startup = 1

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

autocmd CompleteDone * pclose!
let g:airline_theme="andy"

filetype plugin indent on
