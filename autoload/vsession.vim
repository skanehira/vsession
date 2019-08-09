let s:save_cpo = &cpo
set cpo&vim

scriptencoding utf-8

" save session
function! vsession#save() abort
	let file = input("file:")
	if file ==# ''
		call s:echo_err('please input file name')
		return
	endif
	execute 'silent mksession!' s:_path_join(file)
	redraw | echo 'saved' file
endfunction

" load session
function! vsession#load() abort
	if exists('*fzf#run()') && get(g:, 'vsession_use_fzf', 0)
		call fzf#run({
					\  'source': readdir(g:vsession_path),
					\  'sink':    function('s:_load_session'),
					\  'options': '+m -x +s',
					\  'down':    '40%'})

	elseif has('patch-8.1.1575')
		let l:sessions = readdir(g:vsession_path)
		call popup_menu(l:sessions, {
					\ 'filter': 'popup_filter_menu',
					\ 'callback': function('s:_load_session_filter', [l:sessions]),
					\ 'borderchars': ['-','|','-','|','+','+','+','+'],
					\ })
	else
		call s:_load_session(input('file:'))
	endif
endfunction

" delete session
function! vsession#delete() abort
	if exists('*fzf#run()') && get(g:, 'vsession_use_fzf', 0)
		call fzf#run({
					\  'source': readdir(g:vsession_path),
					\  'sink':    function('s:_delete_session'),
					\  'options': '-m -x +s',
					\  'down':    '40%'})

	elseif has('patch-8.1.1575')
		let l:sessions = readdir(g:vsession_path)
		call popup_menu(l:sessions, {
					\ 'filter': 'popup_filter_menu',
					\ 'callback': function('s:_delete_session_filter', [l:sessions]),
					\ 'borderchars': ['-','|','-','|','+','+','+','+'],
					\ })
	else
		call s:_delete_session(input("file:"))
	endif
endfunction

function! s:_path_join(file) abort
	return g:vsession_path . '/' . a:file
endfunction

function! s:_load_session_filter(sessions, id, idx) abort
	if a:idx ==# -1
		return
	endif

	call s:_load_session(a:sessions[a:idx-1])
endfunction

function! s:_load_session(file) abort
	if a:file ==# ''
		call s:echo_err('please input file name')
		return
	endif

	execute 'silent source' s:_path_join(a:file)
	redraw | echo 'loaded' a:file
endfunction

function! s:_delete_session_filter(sessions, id, idx) abort
	if a:idx ==# -1
		return
	endif

	call s:_delete_session(a:sessions[a:idx-1])
endfunction

function! s:_delete_session(file) abort
	if a:file ==# ''
		call s:echo_err('please input file name')
		return
	endif

	call delete(s:_path_join(a:file))
	redraw | echo 'deleted' a:file
endfunction

function! s:echo_err(message) abort
	echohl ErrorMsg
	redraw
	echo a:message
	echohl None
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
