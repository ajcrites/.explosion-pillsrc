" Vim global plugin for automating response to swapfiles
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

"#############################################################
"##                                                         ##
"##  Note that this plugin only works for Vim sessions      ##
"##  running in Terminal on MacOS X. And only if your       ##
"##  Vim configuration includes:                            ##
"##                                                         ##
"##     set title titlestring=                              ##
"##                                                         ##
"##  See below for the two functions that would have to be  ##
"##  rewritten to port this plugin to other OS's.           ##
"##                                                         ##
"#############################################################


" If already loaded, we're done...
if exists("loaded_autoswap_tmux")
    finish
endif
let loaded_autoswap_tmux = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim

" Invoke the behaviour whenever a swapfile is detected...
"
augroup AutoSwap_Tmux
    autocmd!
    autocmd SwapExists *  call AS_T_HandleSwapfile(expand('<afile>:p'))
augroup END


" The automatic behaviour...
"
function! AS_T_HandleSwapfile (filename)

    " Is file already open in another Vim session in some other Terminal window???
    let active_window = AS_T_DetectActiveWindow(a:filename)

    " call AS_T_DelayedMsg(active_window)
    call AS_T_DelayedMsg("FOOOO")

    " If so, go there instead and terminate this attempt to open the file...
    if (strlen(active_window) > 0)
        call AS_T_DelayedMsg('Switched to existing session in another window' + active_window)
        call AS_T_SwitchToActiveWindow(active_window)
        let v:swapchoice = 'q'

    " Otherwise, if swapfile is older than file itself, just get rid of it...
    elseif getftime(v:swapname) < getftime(a:filename)
        call AS_T_DelayedMsg("Old swapfile detected...and deleted")
        call delete(v:swapname)
        let v:swapchoice = 'e'

    " Otherwise, open file read-only...
    else
        " call AS_T_DelayedMsg("Swapfile detected...opening read-only")
        " let v:swapchoice = 'o'
    endif
endfunction


" Print a message after the autocommand completes
" (so you can see it, but don't have to hit <ENTER> to continue)...
"
function! AS_T_DelayedMsg (msg)
    " A sneaky way of injecting a message when swapping into the new buffer...
    augroup AutoSwap_Tmux_Msg
        autocmd!
        " Print the message on finally entering the buffer...
        autocmd BufWinEnter *  echohl WarningMsg
        exec 'autocmd BufWinEnter *  echon "\r'.printf("%-60s", a:msg).'"'
        autocmd BufWinEnter *  echohl NONE

        " And then remove these autocmds, so it's a "one-shot" deal...
        autocmd BufWinEnter *  augroup AutoSwap_Mac_Msg
        autocmd BufWinEnter *  autocmd!
        autocmd BufWinEnter *  augroup END
    augroup END
endfunction


"#################################################################
"##                                                             ##
"##  Rewrite the following two functions to port this plugin    ##
"##  to other operating systems.                                ##
"##                                                             ##
"#################################################################

" Return an identifier for a terminal window already editing the named file
" (Should either return a string identifying the active window,
"  or else return an empty string to indicate "no active window")...
"
function! AS_T_DetectActiveWindow (filename)
    let shortname = fnamemodify(a:filename,":t")
    let possible_windows_string = system('tmux list-panes -a -F "#{pane_id}|#{pane_pid}"')
    let possible_windows = split(system('tmux list-panes -a -F "#{pane_id}|#{pane_pid}"'))
    let found_pane = ""
    for x in possible_windows
        let pane = split(x, "|")
        let command = system('pgrep -P ' . pane[1] . ' | xargs -I{} ps -o command {} | \grep ^vim | tr -d "\n"')
        if command =~ "^vim.*" . shortname . " *$"
            let found_pane = pane[0]
        endif
    endfor
    return found_pane
endfunction


" Switch to terminal window specified...
"
function! AS_T_SwitchToActiveWindow (active_window)
    " call AS_T_DelayedMsg(a:active_window)
    call AS_T_DelayedMsg("FOOO")
    if strlen(a:active_window)
        " call AS_T_DelayedMsg(a:active_window)
        " call system('tmux select-window -t ' + a:active_window)
        call AS_T_DelayedMsg(a:active_window)
        call system('tmux select-window -t ' . a:active_window)
    endif
endfunction

" Restore previous external compatibility options
let &cpo = s:save_cpo
