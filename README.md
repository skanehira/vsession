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
Also reference help.

```vim
" save the session.
:SaveSession

" load the session.
:LoadSession

" delete session.
:DeleteSession
```

