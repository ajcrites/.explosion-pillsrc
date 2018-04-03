" @File              : .vimrc for ajcrites
set t_Co=256

" call pathogen#infect()

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

" let g:python2_host_prog = '/usr/local/bin/python'
" let g:python3_host_prog = '/usr/local/bin/python3'

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
autocmd BufEnter .babelrc set filetype=json

autocmd BufEnter * set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter package.json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter tsconfig.json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter tslint.json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter project.json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter swagger.yaml set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter *.ts set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter *.tsx set softtabstop=2 tabstop=2 shiftwidth=2

" project-specific indentation
autocmd BufEnter ~/projects/mobq/kinvey/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/aliro-platform/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/knight/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/insulet/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/mobq/tcp/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/personal/hide-gnv-seek/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/personal/times-tables/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/personal/react-lessons/* set softtabstop=2 tabstop=2 shiftwidth=2
autocmd BufEnter ~/projects/personal/tslint-react/* set softtabstop=4 tabstop=4 shiftwidth=4

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

" shortcuts
inoremap clg console.log()<Left>
inoremap cl; console.log();<Left><Left>

" move or edit functions / blocks as groups
map fd <Esc><Home>/{\\|}<Return><C-l>d%dd
map fj <Esc><Home>/{\\|}<Return><C-l>V%:m<Space>'>+1<CR>=
map fk <Esc><Home>/{\\|}<Return><C-l>V%:m<Space>'<-2<CR>=

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

map q: :q
map :Sp :sp
map :W :w

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
abbr improt import

" syntax mistypes
imap <Br <br
imap codE> code>
imap 4_ $_
imap if( if<Space>(
imap $> %>
imap (<Space>= () =

"make `-` a word character so I can autocomplete words containing dashes
function! DashToggle()
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
nmap sy :PrettierAsync<CR>

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

" Gundo
nnoremap <F5> :GundoToggle<CR>

" jsx
let g:jsx_ext_required = 1

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

let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_single_quote_import = 1
set statusline+=%#warningmsg#
set statusline+=%*

" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'

let g:ale_linters = {
\ 'typescript': ['tslint', 'tsserver'],
\ 'rust': ['cargo'],
\ 'javascript': []
\}
let g:ale_fixers = {
\ 'typescript': ['tslint']
\}

let g:ale_rust_cargo_use_check = 1

let g:codi#interpreters = {
\ 'typescript': {
    \ 'bin': ['ts-node'],
    \ 'prompt': '^\(>\|\.\.\.\+\) ',
    \ },
\}

" camelCase motion is more common than search motion.
" I never use the default bindings of ' and "
let g:wordmotion_mappings = {
\ 'w' : 'n',
\ 'b' : 'N',
\ }
nnoremap ' n
nnoremap " N
nnoremap <C-b> "

let g:loaded_matchparen = 1
let g:qf_loclist_window_bottom = 0

let g:dispatch_compilers = {}
let g:dispatch_compilers['node_modules/.bin/jest'] = 'jest-cli'

let g:test#javascript#jest#options = '--reporters vim-test-jest-clean-qf-reporter'
let g:test#strategy = 'dispatch'
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$'

" tree
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 20

" neovim plugins
if &compatible
    set nocompatible
endif
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(expand('~/.config/nvim/dein'))
    call dein#begin(expand('~/.config/nvim/dein'))

    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('Shougo/deoplete.nvim')
    " call dein#add('Quramy/tsuquyomi')
    call dein#local('~/projects/personal', {}, ['tsuquyomi'])
    " call dein#add('mhartington/deoplete-typescript')
    " call dein#add('mhartington/nvim-typescript')
    " call dein#add('carlitux/deoplete-ternjs')
    call dein#add('tweekmonster/nvim-checkhealth')
    call dein#add('Quramy/vim-js-pretty-template')
    call dein#add('jason0x43/vim-js-indent')
    " call dein#add('leafgarland/typescript-vim')
    " call dein#add('ervandew/supertab')
    call dein#add('hashivim/vim-terraform')
    call dein#add('rust-lang/rust.vim')
    call dein#add('ElmCast/elm-vim')
    " call dein#add('w0rp/ale')
    call dein#local('~/projects/personal', {}, ['ale'])
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
    " call dein#add('othree/html5.vim')
    " call dein#add('elzr/vim-json')
    call dein#add('moll/vim-node')
    call dein#add('sickill/vim-pasta')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('mattn/webapi-vim')
    call dein#add('ajcrites/xmledit')
    call dein#add('prettier/vim-prettier')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('suan/vim-instant-markdown')
    call dein#add('metakirby5/codi.vim')
    call dein#add('AndrewRadev/sideways.vim')
    call dein#add('romainl/vim-qf')
    call dein#add('mxw/vim-jsx')
    call dein#add('itchyny/vim-parenmatch')
    call dein#add('junegunn/vader.vim')
    call dein#add('janko-m/vim-test')
    call dein#add('tpope/vim-dispatch')
    " call dein#add('benmills/vimux')
    " call dein#local('~/projects/personal', {}, ['vim-test'])
    call dein#local('~/projects/personal', {}, ['vim-jest-cli'])

    call dein#end()
    call dein#save_state()
endif

let g:prettier#autoformat = 0

let g:prettier#config#parser = 'typescript'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#bracket_spacing = 'true'

nnoremap <C-h> :SidewaysJumpLeft<cr>
nnoremap <C-n> :SidewaysJumpRight<cr>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" autocmd BufWritePre ~/projects/mobq/tcp/*.ts PrettierAsync
autocmd BufWritePre ~/projects/personal/times-tables/*.tsx PrettierAsync

let g:prettier#quickfix_enabled = 0

autocmd BufWritePre,InsertLeave ~/projects/personal/react-lessons/*.tsx let g:prettier#config#parser = 'typesript'
autocmd BufWritePre,InsertLeave ~/projects/personal/react-lessons/*.tsx let g:prettier#config#single_quote = 'true'
autocmd BufWritePre,InsertLeave ~/projects/personal/react-lessons/*.tsx let g:prettier#config#trailing_comma = 'all'
autocmd BufWritePre,InsertLeave ~/projects/personal/react-lessons/*.tsx let g:prettier#config#bracked_spacing = 'true'
autocmd BufWritePre ~/projects/personal/react-lessons/*.tsx PrettierAsync

let g:multi_cursor_next_key = '<C-g>'
let g:multi_cursor_prev_key = '<C-f>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '@'

" let g:deoplete#disable_auto_complete = 1
" let g:deoplete#enable_at_startup = 1

" omni completion with <Tab>
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ "\<C-x>\<C-o>"

" keyword completion with S-tab
" ;<TAB> multikey
imap ;<TAB> <S-tAB>
inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ "\<C-p>"

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

autocmd CompleteDone * pclose!
" let g:airline_theme="andy"

filetype plugin indent on

" putting this here gets vim-jsx to work for typescript
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx

colorscheme andy

highlight Badspace ctermfg=red ctermbg=red
au VimEnter,BufWinEnter * syn match Badspace /\s\+$/ containedin=ALL | hi link customBadWhitespace Error

let g:ale_open_list = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 80
let g:ale_list_vertical = 1

nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
nmap <C-d> :call AleToggle()<cr>

nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

let s:aleopen = 1
function! AleToggle()
    if s:aleopen
        ALEDisable
        sleep 100m
        let s:aleopen = 0
        let g:ale_open_list = 0
        ALEEnable
    else
        ALEDisable
        let s:aleopen = 1
        let g:ale_open_list = 1
        ALEEnable
    endif
endfunction

" Quick Toggle for Codi
" Codi doesn't really play nice with ALE, and ALE will close Codi if it's open
" and there are no errors. Instead, use a hotkey to make them play along
" better. The sleep 500m prevents an error from popping up with Codi for some
" reason...
nnoremap <silent> <C-c> :call CodiToggle()<cr>

let s:codiopen = 0
function! CodiToggle()
    if s:codiopen
        let s:codiopen = 0
        let g:codi#autoclose = 0
        sleep 500m
        Codi!
        let g:ale_keep_list_window_open = 0
        ALELint
    else
        let s:codiopen = 1
        let g:ale_keep_list_window_open = 1
        Codi
    endif
endfunction

" This fixes Tsuquyomi
autocmd BufEnter *.ts TsuReload
autocmd BufEnter *.tsx TsuReload
