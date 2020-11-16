## First Spark Job on the K8s Cluster

This is a continuation from [this previous post](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup). That is, the exact environment created is built upon here.

### Build a Docker Image

We are going to build the sample Docker image that comes with Spark. This is the image that will eventually be used in our pods when our spark job is running.

```
# Build the sample docker image
cd /opt/spark
sudo docker build -t spark:latest -f kubernetes/dockerfiles/spark/Dockerfile .
```

We will call the image **spark:latest** for now.

### Docker Hub

We need to publish our docker image to Docker Hub (there are other options at this point).

* [Create a Docker Hub account](https://hub.docker.com)
* [Create a repository](https://hub.docker.com/repositories) (from the UI)
* Login to Docker (from your EC2 instance):

```
sudo docker login
```

My repository is: **npa02012/test-spark-repo**

### Push Docker Image

Tag and push the sample docker image made above (named **spark:latest**) to the repository just made (named **npa02012/test-spark-repo**):


```
sudo docker tag spark:latest npa02012/test-spark-repo:firstimagepush
sudo docker push npa02012/test-spark-repo:firstimagepush
```

### Make a Service Account for Spark

```
kubectl create serviceaccount spark
kubectl create clusterrolebinding spark-role --clusterrole=edit  --serviceaccount=default:spark --namespace=default
```

### Make Script to Run the Sample Job
```
#!/bin/bash
/opt/spark/bin/spark-submit \
   --master k8s://<SERVER>:443 \
   --deploy-mode cluster \
   --class org.apache.spark.examples.SparkPi \
   --conf spark.kubernetes.file.upload.path=s3a://npa02012-k8s-state/npa02012.k8s.local \
   --conf spark.kubernetes.driver.pod.name=spark-pi-driver \
   --conf spark.kubernetes.container.image=npa02012/test-spark-repo:firstimagepush \
   --conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
   local:///opt/spark/examples/jars/spark-examples_2.12-3.0.1.jar
```

Where **\<SERVER\>** is the cluster API server address, found by calling:  

```
kubectl config view
```

Note that the *spark.kubernetes.file.upload.path* and *spark.kubernetes.container.image* arguements may also vary for you.

### Conclusion

The script above should execute successfuly. Here is a sample output received from the job:

```
Out:
-------------------------  
 phase: Succeeded
 container status: 
	 container name: spark-kubernetes-driver
	 container image: npa02012/test-spark-repo:firstimagepush
	 container state: terminated
	 container started at: 2020-11-16T00:28:04Z
	 container finished at: 2020-11-16T00:28:41Z
	 exit code: 0
	 termination reason: Completed
```

We just ran our first Spark job on a K8s cluster!  

If you are running into problems, I found it most useful to investigate the pod's logs:  

```
kubectl logs -f spark-pi-driver
```

Note: If you wish to run the script again, you will have to either delete the *spark-pi-driver* pod or alter the *spark.kubernetes.driver.pod.name* arguement of the spark-submit command.
