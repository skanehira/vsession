scriptencoding utf-8

if exists('g:loaded_vsession')
    finish
endif
let g:loaded_vsession = 1


" ユーザー設定を一時退避
let s:save_cpo = &cpo
set cpo&vim

" session commands
command! -nargs=1 SaveSession call vsession#save(<f-args>)
command! -nargs=1 LoadSession call vsession#load(<f-args>)
command! -nargs=1 DeleteSession call vsession#delete(<f-args>)

" session use fzf
command! FloadSession call fzf#run({
\  'source': split(expand('~/.vim/sessions/*'), "\n"),
\  'sink':    function('vsession#load'),
\  'options': '-m -x +s',
\  'down':    '40%'})

command! FdeleteSession call fzf#run({
\  'source': split(expand('~/.vim/sessions/*'), "\n"),
\  'sink':    function('vsession#delete'),
\  'options': '-m -x +s',
\  'down':    '40%'})

" 退避していたユーザ設定を戻す
let &cpo = s:save_cpo
unlet s:save_cpo
