## PySpark on K8s Cluster

In this post, we will build a more robust Spark application to run on our K8s cluster. This work builds off of the environment created in [this post](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup).

https://github.com/lp-dataninja/SparkML/blob/master/kaggle-titanic-pyspark.ipynb

### Scratch Work


```
pip3 install numpy
pip3 install boto3
```

```
export PYSPARK_PYTHON=/usr/bin/python3
/opt/spark/bin/spark-submit main.py
```



https://stackoverflow.com/questions/51673011/how-to-mount-s3-bucket-on-kubernetes-container-pods




## Get Jupyter Notebook on EC2

Instructions from [here](https://docs.aws.amazon.com/dlami/latest/devguide/dlami-dg.pdf#setup-jupyter) (page 20, **Set up a Jupyter Notebook Server**).

### Setup

```
pip3 install jupyter
jupyter notebook password #ow123123

cd ~
mkdir ssl
cd ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
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




