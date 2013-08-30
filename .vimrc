" @File              : .vimrc for ajcrites

call pathogen#infect()

set nu               " Set line numbering
set nocompatible     " Not like Vi
filetype plugin on

syntax on            " Enable syntax highlighting
set autoindent       " Autoidentation on
set smartindent      " Smartindentation on
set showmatch        " Blink back to closing bracket (using % key)

"set tabstop=3        " Set Tab size @gleim
set expandtab        " Expand Tabs (pressing Tab inserts spaces)
"set shiftwidth=3     " Number of spaces to use for each step of (auto)indent
"set softtabstop=3    " makes the spaces feel like real tabs; one backspace goes back 3 spaces :)
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set list listchars=tab:>-
retab               " force all Tab characters to match current Tab preferences

"set list listchars=tab:**
autocmd FileType spec set filetype=xml
autocmd BufEnter *.zsh-theme set filetype=sh

autocmd BufEnter * set shiftwidth=4 tabstop=4 softtabstop=4

autocmd BufEnter *.php  set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter */Desktop/* set shiftwidth=8 tabstop=8 softtabstop=8
autocmd BufEnter *.py   set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter *.html set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter *.css  set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter *.sql  set shiftwidth=2 tabstop=2 softtabstop=2

autocmd BufEnter *.xml  set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter *.spec set shiftwidth=4 tabstop=4 softtabstop=4
autocmd BufEnter *.xsl  set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter *.xsd  set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter *.java set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufEnter *.md set shiftwidth=4 tabstop=4 softtabstop=4

"Remember last line after opening file (from /etc/vim/vimrc
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


"source ~/.vim/php-doc.vim
inoremap <C-P><ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P>:call PhpDocSingle()<CR>
vnoremap <C-P>:call PhpDocRange()<CR>

"source /usr/share/vim/vim70/syntax/php.vim
" source /usr/share/vim/vim70/indent/php.vim
set dictionary+=/home/ajcrites/.vim/bundle/vim-explosion-pills/phpfunctions.txt
set complete-=k complete+=k

set bs=2             " backspace ???
"set spell spelllang=en_us
" set syntax=indera " Use coloring defined in ~/.vim/syntax/indera.vim

let g:vimsyn_folding='af'
set fdm=syntax
let php_folding=2
let javaScript_fold=1
" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-

set background=dark  " Highlighting depends on background color (dark or light)

" Turn off search wrapping
  " 'gg' go on top and serch with '/'
  " 'g' go at bootom and search with '?'
set nowrapscan
set ignorecase       " Ignore case in search
set smartcase        " Consider case only when typing Uppercase
"set incsearch        " Show search results when typing
set hlsearch         " highlight search pattern
set vb t_vb=         " don't notify (no audio/visual bell)
set showmode         " display mode INSERT/REPLACE/...
"set textwidth=99     " break line at 100 chars
set scrolloff=3      " dont let the curser get too close to the edge
set laststatus=2     " laststatus:  show status line?  Yes, always!
set nonumber

au Filetype php set spell
au Filetype html set spell
au Filetype xhtml set spell
au Filetype md set spell
au Filetype txt set spell

" -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

map!  <F1>     <ESC>                   " F1 != Help; remove access to help :)
map   <F1>     <ESC>
map   <F2>     <ESC>:w                 " Save file ? (Enter for Yes)
map   <F3>     <ESC>:q                 " Exit now ?

" File name
map   <F4>     :echo "File name: " . expand("%")      <CR>

" switch lines
"map   <F5>     ddkkp<CR>
"map   <F6>     ddpk<CR>

" Fold a block of code
map   <F6>     zfa{
" Unfold a block of code
map   <F7>     zo

"map   <F7>     :call SetSpace2() <CR>
"map   <F8>     :set nopaste!           " Set nopaste?
"map   <F3>     :Sexplore <CR>          " Load file


"map   <F9>     :echo system("php " . expand("%"))     <CR>
"map   <F10>    :echo system("php -l " . expand("%"))  <CR>

" Unhighlight search results
" map <F10> :nohl <CR>

" Switch background colors
"map <F11> :let &background = ( &background == "dark"? "light" : "dark" ) <CR>
" Toggle line numbering on/off
"map <F12> :set nonumber! <CR>

"map! pp <ESC>

" In visual mode: TAB and Shift-TAB for indenting
vmap <TAB>     >
vmap <S-TAB>   <

"       Example: 04.09.00 - 09:53
iab YDT           <C-R>=strftime("%d.%m.%y - %H:%M")<CR>
"       insert the current filename *without* path:
iab YFILE <C-R>=expand("%:t:r")<cr>

" set viminfo='10,\"100,:20,%,n~/.viminfo

au BufReadPost *
\if line("'\"") > 0 |
\  if line("'\"") <= line("$") |
\     exe("norm '\"") |
\  else |
\     exe "norm $" |
\  endif |
\endif

" Define functions
" http://www.vim.org/tips/tip.php?tip_id=271
function! PoundComment()
  map - :s/^/# /<CR>
  map _ :s/^\s*# \=//<CR>
  set comments=:#
endfunction

function! SlashComment()
  map - :s/^/\/\/ /<CR>        :nohlsearch<CR>
  map _ :s/^\s*\/\/ \=//<CR>   :nohlsearch<CR>
endfunction

" And then later... - or _
autocmd FileType perl      call PoundComment()
autocmd FileType sh        call PoundComment()
autocmd FileType php       call SlashComment()
autocmd FileType php       call WriteTags()
autocmd FileType java      call SlashComment()

"Write the opening and closing php tags to an empty file
fu! WriteTags()
 if line("$") == 1
    call append(0, "<?php")
  endif
endfunction

function SetSpace2()
  set shiftwidth=2 tabstop=2 softtabstop=2
endfunction

colorscheme andy

highlight Badspace ctermfg=red ctermbg=red
au VimEnter,BufWinEnter * syn match Badspace /\s\+$/ containedin=ALL | hi link customBadWhitespace Error

"Quirky mappings
map j <Left>
map k <Down>
nnoremap K i<CR><Esc>
map l <Up>
map ; <Right>
map , <PageDown>
"Prevent pause on dd waiting for dt/df
noremap dd dd
noremap dt dt
noremap yy yy
noremap yt yt
noremap df df
noremap t .
map . <PageUp>
map f 5
map <C-w>j <C-w><Left>
map <C-w>k <C-w><Down>
map <C-w>l <C-w><Up>
map <C-w>; <C-w><Right>

"Delete a function or a loop
map fd <Esc><Home>/{<Return><C-l>d%dd

"Create matching braces
inoremap {{ {<Esc>o}<Up><Esc>o
inoremap {; {<Esc>o};<Up><Esc>o
inoremap {( {<Esc>o})<Up><Esc>o
inoremap (; {<Esc>o});<Up><Esc>o
inoremap 2{ {{}}<Left><Left>

"Created matches for building arrays, functions, etc.
imap [' ['']<Left><Left>
imap [" [""]<Left><Left>

"<Esc> from the home row
imap ij <Esc>
vmap ij <Esc>

"Quickly build common loops or functions
imap foreach foreach<Space>($)<Space>{{<Up><Home><Esc>/\$<Return><C-l>a
map foreach iforeach

imap whilel while<Space>($)<Space>{{<Up><Home><Esc>/\$<Return><C-l>a

imap mfar mysql_fetch_assoc($result);
imap cfar cron_mfar

map Z o<Esc>

imap fnc function<Space>()<Space>{{<Up><Home><Esc>/(<Return><C-l>i
map fnc ifnc

map rfnc irfnc
map vfnc ivfnc

imap vd var_dump();<Left><Left>
imap dvd die(var_dump());<Left><Left><Left>

"Quick tab navigation
nnoremap <C-l> :nohl<CR>

"Quick spli navigation
nnoremap <C-s> :sp

"Proprietary Rights Notice macro
inoremap /prop <Esc>mqggo<CR><Esc>:set<Space>paste<CR>i
\/* PROPRIETARY RIGHTS NOTICE<CR>
\ *  This material contains valuable proprietary and trade secret<CR>
\ *  information of Gleim Publications, Inc. of Gainesville, Florida.<CR>
\ *  Except in the furtherance of the business activities of Gleim<CR>
\ *  Publications, Inc., no part of such information may be disclosed, used,<CR>
\ *  reproduced or transmitted in any form or by any means - electronic,<CR>
\ *  mechanical, optical or otherwise including photocopying and recording<CR>
\ *  in connection with any processing, storage or retrieval system -<CR>
\ *  without prior written permission from Gleim Publications, Inc.<CR>
\ *<CR>
\ * COPYRIGHT NOTICE<CR>
\ *  Copyright <C-R>=strftime("%Y")<CR> by Gleim Publications, Inc. and/or Gleim Internet, Inc.<CR>
\ *  All worldwide rights reserved.<CR>
\ *<CR>
\ *  4201 NW 95th Boulevard<CR>
\ *  Gainesville, FL  32606<CR>
\ */<Esc>:set<Space>nopaste<CR>`q
map &prop i/prop

"PHPDoc Macros
inoremap /purp <Esc>:set<Space>paste<CR>i
\/**<CR>
\ * The purpose of this file is to  <Esc>mqi<CR>
\ * @author Andrew Crites <andrew@gleim.com><CR>
\ * @copyright <C-R>=strftime("%Y")<CR><CR>
\ * @package<CR>
\ */<Esc>:set<Space>nopaste<CR>`q<S-a>

"Comments
inoremap /+ /**#@+
inoremap /- /**#@-*/

"tag macros
"Create tag from what was just typed; move to edit contents
"Create tag with newlines and indent

"Create tag from what was just typed; move to edit attributes
imap tagat <ESC>jT
"Gut a tag on the line (might not want to use this one if you have more than one tag on the line)
imap tagut <ESC>^<Right>?<[^\/]<CR>:s/>[^<]*</></<CR><C-l>ww;i
imap yyp <Esc>yypi
imap yypt <Esc>yypitagut

"typos
imap springf sprintf
imap <Br <br
imap rlmNAme rlmName
imap cousre course
imap Cousre Course
imap functino function
imap functoin function
imap funciton function
imap funcion function
imap multipe multiple
imap codE> code>
imap 4_ $_
imap if( if<Space>(
imap Gliem Gleim
imap breka break

function! DashToggle()
   echo &iskeyword
   if matchstr(&iskeyword, '-$') == '-'
      set iskeyword-=-
   else
      set iskeyword+=-
   endif
endfunction

"macros for common commands
"s is common command mode
nmap sp :set paste!<CR>
nmap sd :call DashToggle()<CR>
nmap sn :set nonumber!<CR>
nmap ss :set spell!<CR>
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l
nmap s; <C-w>;
nmap <TAB> i<TAB>
"imap cb <Space><Esc>dbxi

"moving between tabs
nmap g0 :tabfirst<CR>
nmap g$ :tablast<CR>
nmap gn :tabn<CR>
nmap gp :tabp<CR>

"typing macros
imap syso System.out.println();<Left><Left>

"complex replacement macros
map sinu :s/^/\=(1-line("'<")+line('.')-1) /<CR>:'<,'>s/^\(\d\+\)\(.\+\)/\1 \2/<CR>:nohl<CR>
map sist :s/\(\s\+\)\(.*\)/\1<li>\2<\/li><CR>:nohl<CR>
map sidt :s/\d\+\. \(.*\)/      <li>\1<\/li><CR>:nohl<CR>
map siat :s/\w\+\. \(.*\)/      <li>\1<\/li><CR>:nohl<CR>

set ttymouse=xterm2
set mouse=a

" Directories for swap files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
let xml_tag_completion_map = "@"

set colorcolumn=80
autocmd BufEnter *.md set colorcolumn=60

" Easymotion
let g:EasyMotion_mapping_j = '<Leader><Leader>k'
let g:EasyMotion_mapping_k = '<Leader><Leader>l'
