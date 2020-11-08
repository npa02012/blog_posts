## Next

### Build Spark Driver Image

```
cd /opt/spark
./bin/docker-image-tool.sh -r k8s -m build
```


### Make Script to Run Sample Job
```
#!/bin/bash
/opt/spark/bin/spark-submit \
   --master k8s://https://ec2-xx-xxx-xxx-xxx.compute-1.amazonaws.com:8443 \
   --deploy-mode cluster \
   --name spark-pi \
   --class org.apache.spark.examples.SparkPi \
   --conf spark.executor.instances=3 \
   --conf spark.kubernetes.container.image=k8s/spark \
   --conf spark.kubernetes.namespace=default \
   local:///opt/spark/examples/jars/spark-examples_2.12-3.7.1.jar
```

Where *ec2-xx-xxx-xxx-xxx.compute-1.amazonaws.com* is the Public IPv4 DNS of your K8s master node.



