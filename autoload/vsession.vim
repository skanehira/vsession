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
	call s:_save_session(file)
	redraw | echo 'saved' file
endfunction

function! s:_save_session(file) abort
	execute 'silent mksession!' s:_path_join(a:file)
endfunction

" load session
function! vsession#load() abort
	if len(readdir(g:vsession_path)) <= 0
		call s:echo_err('there are no session items.')
		return
	endif
    let l:ui = get(g:, 'vsession_ui', 'quickpick')
	if exists('*fzf#run()') && l:ui ==# 'fzf'
		call fzf#run({
					\  'source': readdir(g:vsession_path),
					\  'sink':    function('s:_load_session'),
					\  'options': '+m -x +s',
					\  'down':    '40%'})
	elseif has('patch-8.1.1575') && l:ui ==# 'popup'
		let l:sessions = readdir(g:vsession_path)
		call popup_menu(l:sessions, {
					\ 'filter': 'popup_filter_menu',
					\ 'callback': function('s:_load_session_filter', [l:sessions]),
					\ 'borderchars': ['-','|','-','|','+','+','+','+'],
					\ })
    elseif l:ui ==# 'input'
		call s:_load_session(input('file:'))
	else
        call vsession#quickpick#open({
            \   'items': readdir(g:vsession_path),
            \   'on_accept': function('s:_on_accept_load_session')
            \ })
	endif
endfunction

function! s:_on_accept_load_session(data, _name) abort
    call vsession#quickpick#close()
    call s:_load_session(a:data['items'][0])
endfunction

" delete session
function! vsession#delete() abort
	if len(readdir(g:vsession_path)) <= 0
		call s:echo_err('there are no session items.')
		return
	endif
    let l:ui = get(g:, 'vession_ui', 'quickpick')
	if exists('*fzf#run()') && l:ui ==# 'fzf'
		call fzf#run({
					\  'source': readdir(g:vsession_path),
					\  'sink':    function('s:_delete_session'),
					\  'options': '-m -x +s',
					\  'down':    '40%'})

	elseif has('patch-8.1.1575') && l:ui ==# 'popup'
		let l:sessions = readdir(g:vsession_path)
		call popup_menu(l:sessions, {
					\ 'filter': 'popup_filter_menu',
					\ 'callback': function('s:_delete_session_filter', [l:sessions]),
					\ 'borderchars': ['-','|','-','|','+','+','+','+'],
					\ })
    elseif l:ui ==# 'input'
		call s:_delete_session(input("file:"))
    else
        call vsession#quickpick#open({
            \   'items': readdir(g:vsession_path),
            \   'on_accept': function('s:_on_accept_delete_session')
            \ })
	endif
endfunction

function! s:_on_accept_delete_session(data, _name) abort
    call vsession#quickpick#close()
    call s:_delete_session(a:data['items'][0])
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
	let s:current_session = a:file
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

	if a:file ==# get(s:, 'current_session', '')
		let s:current_session = ''
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

augroup vsession
	au!
	autocmd VimLeave * call s:save_last_session()
augroup END

function! s:save_last_session() abort
	if get(g:, 'vsession_save_last_on_leave', 1) && !empty(get(s:, 'current_session', ''))
		call s:_save_session(s:current_session)
	endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
