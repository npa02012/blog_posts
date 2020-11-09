## Running a Spark Job on the K8s Cluster

### Install JDK

```
# Try 1.8 (that is what is in the sample docker image)
sudo apt install openjdk-11-jre-headless
```

### Run a Local Sample Job

```
PYSPARK_PYTHON=/usr/bin/python3
cd /opt/spark
./bin/spark-submit examples/src/main/python/pi.py 10
```

### Setup

```
# Didn't help (?)
kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default
```
[Good reference](https://towardsdatascience.com/how-to-build-spark-from-source-and-deploy-it-to-a-kubernetes-cluster-in-60-minutes-225829b744f9)  
Searched: simple spark kubernetes spark-submit example  
Trying to submit job from the sample docker image

```
# Build the sample docker image
docker build -t spark:latest -f kubernetes/dockerfiles/spark/Dockerfile .
```
### Make Script to Run Sample Job
```
#!/bin/bash
/opt/spark/bin/spark-submit \
   --master k8s://https://api-npa02012-k8s-local-g65apd-778551732.us-east-1.elb.amazonaws.com:443 \
   --deploy-mode cluster \
   --name spark-pi \
   --class org.apache.spark.examples.SparkPi \
   --conf spark.kubernetes.driver.pod.name=pod_name \
   --conf spark.kubernetes.file.upload.path=s3a://npa02012-k8s-state/npa02012.k8s.local \
   --conf spark.kubernetes.driver.pod.name=spark-pi-driver \
   --conf spark.executor.instances=3 \
   --conf spark.kubernetes.container.image=bitnami/spark \
   --conf spark.kubernetes.namespace=default \
   local:///opt/spark/examples/jars/spark-examples_2.12-3.7.1.jar
```

Where **SERVER** is the cluster API server address, found by calling:  

```
kubectl config view
```

**bitnami/spark** refers to [this publick docker image](https://hub.docker.com/r/bitnami/spark/).


```
./run_spark.sh > result.txt 2>&1
```


### Helpful Commands
```
# docker
sudo docker image ls -a # List all images
sudo docker run -t -i IMAGE_ID /bin/bash
sudo docker container ls # List containers
sudo docker stop CONTAINER_ID

# kubectl
kubectl delete pods spark-pi-driver
kubectl logs -f spark-pi-driver
```


