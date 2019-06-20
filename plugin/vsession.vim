scriptencoding utf-8

if exists('g:loaded_vsession')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:loaded_vsession = 1

" session path
if !exists('g:session_path')
    let g:session_path = expand('~/.vim/sessions')
endif

if !isdirectory(g:session_path)
    call mkdir(g:session_path, "p")
endif

" session commands
command! -nargs=1 SaveSession call vsession#save(<f-args>)
command! -nargs=1 LoadSessionFile call vsession#load_file(<f-args>)
command! -nargs=0 LoadSession call vsession#load()
command! -nargs=1 DeleteSession call vsession#delete(<f-args>)

" session use fzf
command! FloadSession call fzf#run({
            \  'source': readdir(g:session_path),
            \  'sink':    function('vsession#load_file'),
            \  'options': '-m -x +s',
            \  'down':    '40%'})

command! FdeleteSession call fzf#run({
            \  'source': readdir(g:session_path),
            \  'sink':    function('vsession#delete'),
            \  'options': '-m -x +s',
            \  'down':    '40%'})

let &cpo = s:save_cpo
unlet s:save_cpo
