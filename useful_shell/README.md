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