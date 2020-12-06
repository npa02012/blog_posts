## Loading S3 Data From PySpark

This post outlines the setup and configuration needed to download data in S3 from a PySpark application. THe work builds off of the environment created in [this post](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup).  

### Create a CSV File in S3

Put a CSV file in S3 for example use. You can refer to [this post](https://github.com/npa02012/blog_posts/tree/master/useful_s3) for how to do that in with boto3 in Python.  

In my case, I have uploaded a file with key *test/test.csv* into my *npa02012-main* bucket with the following contents:  

```
col1,col2,col3
d11,d12,d13
d21,d22,d23
d31,d32,d33
d41,d42,d43
d51,d52,d53
```

### Download JAR Files

These modules are necessary for Spark to interact with AWS S3.  

Note: As of this writing, the most recent version of hadoop-aws (3.3.0) is not compatible with Spark 3.0.1.

```
wget -P ~/jars https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar
wget -P ~/jars https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.908/aws-java-sdk-bundle-1.11.908.jar
```

### Download Python Script

[This script](https://raw.githubusercontent.com/npa02012/blog_posts/master/pyspark_s3/resources/spark_s3_example.py) provides the PySpark code needed to access the CSV file from the PySpark application. Note: The *csv_path* variable will need to be altered.  

```
wget -P ~/ https://raw.githubusercontent.com/npa02012/blog_posts/master/pyspark_s3/resources/spark_s3_example.py
``` 

The application will print the number of rows in your CSV file.

### Submit the Application

For this example, we will run the Spark Application locally.


```
export PYSPARK_PYTHON=/usr/bin/python3
/opt/spark/bin/spark-submit \
    --jars /home/ubuntu/jars/aws-java-sdk-bundle-1.11.908.jar,/home/ubuntu/jars/hadoop-aws-3.2.0.jar \
    /home/ubuntu/spark_s3_example.py
```

My example output printed (amongst the Spark logs):  
**Number of rows: 5**

Note: I still need to figure out how to set PYSPARK_PYTHON as a default environment variable that is accessible by Spark in my in my [default setup](https://github.com/npa02012/blog_posts/tree/master/k8s_aws_setup).


