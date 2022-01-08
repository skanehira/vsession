# vsession
This is vim session manager plugin.
It's Can save, load and delete sessions.

[![asciicast](https://asciinema.org/a/261666.svg)](https://asciinema.org/a/261666)

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

" default is 1
let g:vsession_save_last_on_leave = 0

" allowed values are 'quickpick' or 'fzf' or 'popup' or 'input'.
let g:vsession_ui = 'quickpick'
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

