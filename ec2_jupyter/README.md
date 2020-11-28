## Get Jupyter Notebook on EC2

These are commands needed to setup a jupyter notebook server on an EC2 instance, taken from the [official AWS docs](https://docs.aws.amazon.com/dlami/latest/devguide/dlami-dg.pdf#setup-jupyter).  

Successful execution will allow you to connect to your EC2's jupyter server from a client computer. Basically, you will be able to open up jupyter notebooks on your desktop, but have it linked to your (headless) EC2 instance.

### Setup
```
jupyter notebook password # Remember password
```

### Make SSL Certificate
```
cd ~
mkdir ssl
cd ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
cd ../
```
### Start server
```
jupyter notebook --certfile=~/ssl/mycert.pem --keyfile ~/ssl/mykey.key
```

### From Client
```
ssh -i ./ec2_key.pem -N -f -L \
8888:localhost:8888 \
ubuntu@xx.xxx.xxx.xxx
```

### Open from Client

Navigate to:  
https://localhost:8888/tree




