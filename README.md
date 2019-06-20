# vsession
The vim session manager plugin.
Can save,load and delete sessions.

![](screenshots/vsession.gif)

# Installation
```toml
[[plugins]]
repo = 'skanehira/vsession'
```

# Settings
```vim
" default is ~/.vim/sessions
let g:session_path = '/to/your/path'
```

# Usage
save session
```vim
:SaveSession {filename}
```

load session
```vim
" sessions will display in popup window.
" press enter will load specified session.
" press esc will close popup window.
:LoadSession

" use fzf.vim interface
:FloadSession

" load specified session
:LoadSessionFile {filename}
```

delete session
```vim
" delete {filename} session
:DeleteSession {filename}
" use fzf.vim interface"
:FdeleteSession
```
