## Get Jupyter Notebook on EC2

This post builds off of the environment created [here](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup). 

These are commands needed to setup a jupyter notebook server on an EC2 instance, taken from the [official AWS docs](https://docs.aws.amazon.com/dlami/latest/devguide/dlami-dg.pdf#setup-jupyter).  

Successful execution will allow you to connect to your EC2's jupyter server from a client computer. Basically, you will be able to open up jupyter notebooks on your desktop, but have it linked to your (headless) EC2 instance.

### Setup
```
jupyter notebook password # Remember password
```

### Make SSL Certificate

It is fine to leave all of the locality information empty. The official documentation recommends to enter a "**.**" if you wish to leave it blank.

```
cd ~
mkdir ssl
cd ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
cd ../
```
### Start server

Before starting the Jupyter server, consider [one of these options](https://stackoverflow.com/questions/47331050/how-to-run-jupyter-notebook-in-the-background-no-need-to-keep-one-terminal-for) for starting the notebook in the 'background'. This is particularily relevant if you are ssh'd into the EC2 instance - if you disconnect from the ssh session, the Jupyter server will persist. I use **tmux** here.

```
cd ~
jupyter notebook --certfile=~/ssl/mycert.pem --keyfile ~/ssl/mykey.key
```

### From Client
```
ssh -i ./ec2_key.pem -N -f -L \
8888:localhost:8888 \
ubuntu@xx.xxx.xxx.xxx
```

**xx.xxx.xxx.xxx** being the Public IPv4 address of your instance.

### Open from Client

Navigate to:  
https://localhost:8888/tree  
  
The password is the same one created in the **Setup** seciton.



