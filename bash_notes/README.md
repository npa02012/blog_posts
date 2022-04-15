### General

```bash
# Find all files containing a specific string
grep -rnw '/path/to/somewhere/' -e 'pattern'

# Extract contents of jar file:
jar xf ./path/to/file.jar
```

### Loop through an array

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

### Scripting Notes

---

**source** and **.** are synonymous. Used to source the contents of a file into the current shell.

---

Subcommands:

* -t : Returns 1 if stdout is connect to the terminal.
* -f file_name : True if file exists and is regular file.
* -z string : Checks if string is NULL (e.g: -z "$VAR")
* -n string: Checks if string is not null.

---

* set -a : Mark variables and function which are modified or created for export to the environment of subsequent commands.
* set -e : Exit if pipeline returns non-zero exit status.


---

If VARIABLE is null, then set FOO to defaultValue.  
[More info.](https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash)

```
FOO=${VARIABLE:-defaultValue}
```