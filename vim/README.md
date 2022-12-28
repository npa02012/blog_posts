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
or
:tabe ./path/to/file.py
:tabp or :tabn - previous and next tabs

Ctrl+Q. Highlight section and delete with "d"
:set mouse=a to allow clicking

/test — search for “test”. n to go to next. N to go to previous.
:set hlsearch — Highlight search results
% — Find match brackets/parantheses.
:s/abc/123/gc — replace all “abc” with “123” in a line, with confirmation
- :%s/ ... might be needed. Without "%" may only match current line.
:1,20s/abc/123/g — replace all from lines 1 to 20
:%s/abc/123/gc — replace all in file, with confirmation

:q! — will exit withouot saving
wq — quit with saving

2w — move forward two words
3e — move to end of 3rd word forward
4b — Move back 4 words
$ — move to end of line
0 or ^ — move to beginning of line
G — move to bottom of file
gg — move to top of file

i — insert
a — append

dd — delete an entire line
4dd — delete 4 lines
d3w — delete next three words
x — delete character

u — undo
U — return line to it’s orignal state

p — paste most recently deleted text
rz — replace character with “z”
ce — delete to end of word then go into INSERT
c$ — delete to end of word then go into INSERT

100gg or 100G — move to line 100
ctrl g — get current line
v — visual mode. y to yank (copy) highlighted text. p to paste.
```
