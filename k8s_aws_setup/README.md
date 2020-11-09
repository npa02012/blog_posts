## Launching a K8s Cluster from an EC2 Instance

#### Setup

* [Make an Amazon EC2 Key Pair](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2-keypairs.html#displaying-a-key-pair)
* Make an IAM Role:
	* Trusted Entity: AWS Service
	* Use case: EC2
	* Policies: AdministratorAccess


#### Launch an EC2 Instance:

* Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-0dba2cb6798deb6d8 (64-bit x86)
* Instance Type: t2.medium
* Configuration Instance Details: Default, except add the IAM role from above.
* On launch, add the key pair made above

#### Connect to the EC2 Instance
Now connect to the instance:  

* ec2_key.pem is th PEM file associated with the Amazon EC2 Key Pair you made above.
* xx.xxx.xxx.xxx is Public IPv4 address of the EC2 instance. 

```
ssh -i ./ec2_key.pem ubuntu@xx.xxx.xxx.xxx
```

#### Setup Environment of Instance
```
wget https://raw.githubusercontent.com/npa02012/blog_posts/master/k8s_aws_setup/resources/ubuntu_setup.sh
chmod +x ubuntu_setup.sh
./ubuntu_setup.sh
```
**Add removal of spark-3.0.1-bin-hadoop3.2.tgz from home folder**  

```
rm spark-3.0.1-bin-hadoop3.2.tgz
```

The script above uses commands from:  

* [Installing Docker](https://docs.docker.com/engine/install/ubuntu/)  
* [Install kOps and kubectl](https://github.com/kubernetes/kops/blob/master/docs/install.md)

##### Setup an S3 Bucket:
You only have to do this once:

```shell
aws s3api create-bucket --bucket npa02012-k8s-state --region us-east-1
```

### Create a Cluster Configuration

```shell
export KOPS_STATE_STORE=s3://npa02012-k8s-state
export CLUSTER_NAME=npa02012.k8s.local
kops create cluster --zones=us-east-1a ${CLUSTER_NAME}
```

Note: We use [kOps Gossip DNS](https://github.com/kubernetes/kops/blob/master/docs/gossip.md) to avoid having to setup an external DNS. To use, Gossip DNS, we end the cluster domain name in *.k8s.local*.  

Note: *KOPS\_STATE\_STORE* tells kOps where to store the cluster's configuration files. After creating the cluster, there is now a folder in my S3 bucket named *npa02012.k8s.local/* with the configuration files.

### Get the Cluster Running

The *create cluster* command will not build the cluster. There may be a flag you can add to do so; I instead used the following command to get it running:

```shell
kops update cluster ${CLUSTER_NAME} --yes
```

After a few minutes, the cluster should be running. Check by running the following:


```shell
kubectl get nodes

Out:
-------------------------
NAME                            STATUS   ROLES    AGE   VERSION
ip-172-20-41-34.ec2.internal    Ready    node     15m   v1.18.10
ip-172-20-47-154.ec2.internal   Ready    master   16m   v1.18.10
ip-172-20-62-58.ec2.internal    Ready    node     15m   v1.18.10
```  

[This article](https://brunocalza.me/2017/03/14/getting-started-with-kubernetes-on-aws/) provides some interesting insight into what kOps is doing behind the scenes, see the **Creating a cluster** section.

Finally we can delete the cluster by running the following:  

```shell
kops delete cluster --name ${CLUSTER_NAME} --yes
```

Note: This will delete the cluster configuration files in the S3 bucket. We will have to recreate the cluster configuration to build the cluster again (I'm sure there are flags to add to **kops delete** to prevent this).