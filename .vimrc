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

autocmd FileType spec set filetype=xml
autocmd BufEnter *.less set filetype=css
autocmd BufEnter *.go set filetype=go
autocmd BufEnter *.zsh-theme set filetype=sh
autocmd BufEnter *.es6 set filetype=javascript
autocmd BufEnter *.es7 set filetype=javascript
autocmd BufEnter *.php set dictionary+=/home/ajcrites/.vim/bundle/vim-explosion-pills/phpfunctions.txt

autocmd BufEnter * set shiftwidth=4 tabstop=4 softtabstop=4

" project-specific indentation
autocmd BufEnter ~/projects/mobq/kinvey/* set softtabstop=2 tabstop=2 shiftwidth=2

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
nmap sp :set paste!<CR>
nmap sd :call DashToggle()<CR>
nmap sn :set nonumber!<CR>
nmap ss :set spell!<CR>
nmap sh <C-w>h
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l

" typing macros
imap syso System.out.println();<Left><Left>

" mouse (in tmux)
set ttymouse=xterm2
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
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

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

" When pressing tab
"  1. If we are already autocompleting, move to next menu item
"  2. If there is no context, insert a tab
"  3. If there is context, do text completion
"  4. If there is a period on the line, do context completion
function! Smart_TabComplete()
    if pumvisible()
        return ""
    endif
    let line = getline('.')                         " current line

    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, '[^ \t]*$')       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return "	"
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    if (!has_period)
        return ""
    else
        return ""
    endif
endfunction

" Shift-tab moves backwards in popup menus
function! Smart_TabNavigation()
    if pumvisible()
        return ""
    endif
    return "	"
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
inoremap <s-tab> <c-r>=Smart_TabNavigation()<CR>
