### .vimrc Profile

```bash
" Allow mouse clicking
set mouse=a

" Stop auto-indenting
set wrap
set linebreak
set nolist
set textwidth=0

" Highlight search results
set hlsearch

" Color scheme
colorscheme blue
```

### vim commands

```
:tabnew ./path/to/file.py
:tabp and :tabn  # Previous and next tabs (navigation)


:%s/abc/123/gc  # Replace all "abc" with "123", with confirmation
```