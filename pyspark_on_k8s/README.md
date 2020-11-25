## PySpark on K8s Cluster

In this post, we will build a more robust Spark application to run on our K8s cluster. This work builds off of the environment created in [this post](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup).

### Scratch Work

```
cd ~
mkdir spark_app
cd spark_app
touch main.py
mkdir tools
touch tools/get_data.py
find .

Out:
-------------------------
.
./main.py
./tools
./tools/get_data.py
```

```
pip3 install boto3
```

```
/opt/spark/bin/spark-submit main.py
```

```
from pyspark.sql import SparkSession

import boto3
s3_resource = boto3.resource('s3')
bucket_name = 'npa02012-main'
s3_bucket = s3_resource.Bucket(bucket_name)
s3_client = boto3.client('s3')

some_binary_data = b'Test data'
object = s3_resource.Object(bucket_name, 'test/test.txt')
object.put(Body=some_binary_data)


import sys
sys.exit()
logFile = "/home/ubuntu/spark_app/test.txt"
spark = SparkSession.builder.appName("SimpleApp").getOrCreate()
logData = spark.read.text(logFile).cache()

numAs = logData.filter(logData.value.contains('a')).count()
numBs = logData.filter(logData.value.contains('b')).count()

print("Lines with a: %i, lines with b: %i" % (numAs, numBs))

spark.stop()


```

https://stackoverflow.com/questions/51673011/how-to-mount-s3-bucket-on-kubernetes-container-pods

