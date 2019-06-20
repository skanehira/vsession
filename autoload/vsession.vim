scriptencoding utf-8

function! s:_path_join(file) abort
    return g:session_path . '/' . a:file
endfunction

function! s:_load_session(sessions, id, idx) abort
    if !a:idx
        return
    endif
    call vsession#load_file(a:sessions[a:idx-1])
endfunction

" save session file
function! vsession#save(file) abort
    execute 'silent mksession!' s:_path_join(a:file)
    echo "saved" a:file
endfunction

" load specified session file
function! vsession#load_file(file) abort
    execute 'silent source' s:_path_join(a:file)
    echo "loaded" a:file
endfunction

" using popup_window to load session file
function! vsession#load() abort
    if has("patch-8.1.1575")
        let l:sessions = readdir(g:session_path)
        call popup_menu(l:sessions, {
                    \ 'filter': 'popup_filter_menu',
                    \ 'callback': function('s:_load_session', [l:sessions]),
                    \ 'borderchars': ['-','|','-','|','+','+','+','+'],
                    \ })
    else
        echoerr "this version not support popup_window"
    endif
endfunction

" delete session
function! vsession#delete(file) abort
    call delete(s:_path_join(a:file))
endfunction

