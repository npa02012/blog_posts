## Useful Snippets for Interacting with S3 Buckets

### From Python:

Basic setup for interaction:

```python
import boto3
s3_session = boto3.Session()
s3_client = boto3.client('s3')
s3_resource = boto3.resource('s3')
bucket_name = 'npa02012-main'
s3_bucket = s3_resource.Bucket(bucket_name)
```
Insert binary data into S3:

```python
b_data = b'Test data going to S3'
object = s3_resource.Object(bucket_name, 'test/test.txt')
object.put(Body=b_data)
```

Upload a local file to S3:

```python
local_name = 'path_to_local_file'
s3_name = 'name_to_be_in_s3'
s3_resource.Bucket('npa02012-main')\
	.upload_file(local_name, s3_name)
```

List all objects in a bucket:

```python
for o in s3_bucket.objects.all():
    print(o)
```

Download a File

```python
s3_key = 'example_in_s3.txt'
local_name = 'save_as.txt'
s3_client.download_file(bucket_name, s3_key, local_name)
```

Download CSV to Pandas (Partial or Full)

```python
import io
key = 'file/to/download'

# Full
obj = s3_client.get_object(Bucket=bucket_name, Key=key)
df = pd.read_csv(io.BytesIO(obj['Body'].read()))

# Partial
obj = s3_client.get_object(Bucket=bucket_name, Key=key)
obj_iter = pd.read_csv(obj['Body'], chunksize = 5)
df = obj_iter.get_chunk()
```

### From Shell:
Create a new bucket:

```
aws s3api create-bucket \
--bucket bucket_name --region us-east-1
```