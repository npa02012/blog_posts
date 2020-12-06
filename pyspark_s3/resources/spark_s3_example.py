import boto3
import pyspark

# Get AWS Creds
s3_session = boto3.Session()
aws_creds = s3_session.get_credentials().get_frozen_credentials()

# Setup spark app
spark_context = pyspark.SparkContext()
spark_session = pyspark.sql.SparkSession \
    .builder \
    .appName("Spark_Download_S3_CSV_Example") \
    .getOrCreate()

# Configure Spark to work with S3
hadoop_conf = spark_context._jsc.hadoopConfiguration()
hadoop_conf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
hadoop_conf.set("fs.s3a.awsAccessKeyId", aws_creds.access_key)
hadoop_conf.set("fs.s3a.awsSecretAccessKey", aws_creds.access_key)

# Download csv file into a spark-df
csv_path = "s3a://npa02012-main/test/test.csv"
df = spark_session.read.option('header', 'true').csv(csv_path)

# Print the number of rows in the dataframe
print('Number of rows: ' + str(df.count()))