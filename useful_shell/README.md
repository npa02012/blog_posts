## Useful Commands

### Encryption (MAC)

```bash
# Encrypt from secrets.md to secrets.enc
openssl enc -aes-256-cbc -salt \
	-in secrets.md \
	-out secrets.enc

# Decrypt from secrets.enc to secrets.md
openssl enc -d -aes-256-cbc \
	-in secrets.enc \
	-out secrets.md
```

### Docker

```bash
sudo docker image ls -a # List all images
sudo docker run -t -i IMAGE_ID /bin/bash
sudo docker container ls # List containers
sudo docker stop CONTAINER_ID
```

### Kubectl

```bash
kubectl delete pods spark-pi-driver
kubectl logs -f spark-pi-driver
```

### Git

```bash
# Make a file in feature branch match master
git checkout origin/master path/to/file

# Get names of files that differ from master
git diff --name-only master
```