### Quick Notes

* Shebang line to ensure bash is used to parse the file:

```bash
#!/bin/bash
```

* Loop through an array:

```bash
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

