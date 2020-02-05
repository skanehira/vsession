let s:save_cpo = &cpo
set cpo&vim

scriptencoding utf-8

if exists('g:loaded_vsession')
	finish
endif

let g:loaded_vsession = 1

if exists('g:vsession_path')
    let g:vsession_path = expand(g:vsession_path)
el
    let g:vsession_path = expand('~/.vim/sessions')
endif

if !isdirectory(g:vsession_path)
	call mkdir(g:vsession_path, "p")
endif

command! SaveSession call vsession#save()
command! LoadSession call vsession#load()
command! DeleteSession call vsession#delete()

let &cpo = s:save_cpo
unlet s:save_cpo
