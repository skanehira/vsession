scriptencoding utf-8

if exists('g:autoloaded_vsession')
    finish
endif

let g:autoloaded_vsession = 1

" session path
let s:session_path = expand('~/.vim/sessions')

if !isdirectory(s:session_path)
    call mkdir(s:session_path, "p")
endif

" save session
function! vsession#save(file)
    execute 'silent mksession!' s:session_path . '/' . a:file
endfunction

" load session
function! vsession#load(file)
    execute 'silent source' a:file
endfunction

" delete session
function! vsession#delete(file)
    call delete(expand(a:file))
endfunction

