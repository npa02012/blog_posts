## Useful Commands

### Docker

```
sudo docker image ls -a # List all images
sudo docker run -t -i IMAGE_ID /bin/bash
sudo docker container ls # List containers
sudo docker stop CONTAINER_ID
```

### Kubectl
```
kubectl delete pods spark-pi-driver
kubectl logs -f spark-pi-driver
```


### Shell

Find all files containing a specific string:

```
grep -rnw '/path/to/somewhere/' -e 'pattern'
```

-

Extract contents of jar file:

```
jar xf ./path/to/file.jar
```
-

**source** and **.** are synonymous. Used to source the contents of a file into the current shell.

-

Subcommands:

* -t : Returns 1 if stdout is connect to the terminal.
* -f file_name : True if file exists and is regular file.
* -z string : Checks if string is NULL (e.g: -z "$VAR")
* -n string: Checks if string is not null.

-

* set -a : Mark variables and function which are modified or created for export to the environment of subsequent commands.
* set -e : Exit if pipeline returns non-zero exit status.

[More]()

-

If VARIABLE is null, then set FOO to defaultValue.

```
FOO=${VARIABLE:-defaultValue}
```

[More](https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash)