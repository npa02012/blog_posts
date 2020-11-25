## Useful Snippets for Interacting with S3 Buckets

### From Python:

Basic setup for interaction:

```python
import boto3
s3_resource = boto3.resource('s3')
bucket_name = 'bucket_name'
s3_bucket = s3_resource.Bucket(bucket_name)
s3_client = boto3.client('s3')
```
Insert binary data into S3:

```python
b_data = b'Here we have some data'
object = s3_resource.Object(bucket_name, 'test/test.txt')
object.put(Body=b_data)

```

### From Shell:
Create a new bucket:

```
aws s3api create-bucket \
--bucket bucket_name --region us-east-1
```