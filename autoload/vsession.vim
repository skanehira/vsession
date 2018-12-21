scriptencoding utf-8

if exists('g:autoloaded_vsession')
    finish
endif

let g:autoloaded_vsession = 1

if !isdirectory(g:session_path)
    call mkdir(g:session_path, "p")
endif

" save session
function! vsession#save(file)
    execute 'silent mksession!' g:session_path . '/' . a:file
endfunction

" load session
function! vsession#load(file)
    execute 'silent source' a:file
endfunction

" delete session
function! vsession#delete(file)
    call delete(expand(a:file))
endfunction

