# vsession
This is vim session manager plugin.
It's Can save, load and delete sessions.

![](screenshots/vsession.gif)

# Installation
ex: dein.vim

```toml
[[plugins]]
repo = 'skanehira/vsession'
```

# Settings
```vim
" default is ~/.vim/sessions.
let g:vsession_path = '/to/your/path'

" if installed fzf.vim, you can use fzf's interface to load and delete session.
" default is false.
let g:vsession_use_fzf = 1
```

# Usage
```vim
" save the session.
"input session file name.
:SaveSession

" load the session.
" if fzf not enable and your vim version is 8.1.1575 or above, sessions will displayed in popup window.
" in the popup window, press enter will load specified session, and press x will close popup window.
" other than that, you should input session file name.
:LoadSession

" delete session.
" Basic operation is the same as LoadSession
:DeleteSession
```
