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
```
env = ${test:-default}
```

### Other

Find all files containing a specific string:

```
grep -rnw '/path/to/somewhere/' -e 'pattern'
```

Extract contents of jar file:

```
jar xf ./path/to/file.jar
```