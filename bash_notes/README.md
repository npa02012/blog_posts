### .vimrc Profile

```bash
# Allow mouse clicking
set mouse=a

# Stop auto-indenting
set wrap
set linebreak
set nolist
set textwidth=0

# Color scheme
colorscheme blue
```

### Quick Notes


* Loop through an array:

```bash
#!/bin/bash

vars=('var0' 'var1' 'var2')

# Loop through values
for v in ${vars[@]}; do
	printf '%s\n' $v
dones

# Loop through indices
for i in ${!vars[@]}; do
	printf 'Value at index %s: %s\n' $i ${vars[$i]}
done

Out:
-------------
var0
var1
var2
Value at index 0: var0
Value at index 1: var1
Value at index 2: var2
```