## K8s Setup

Steps I take to set up Kubernetes to run on AWS EC2 instances. I am following primarily [these instructions](https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md) and I am working from my Mac (running MacOS Sierra).

### Install kubectl, kOps, and AWS CLI

[See here](https://github.com/kubernetes/kops/blob/master/docs/install.md) to install kubectl and kOps. There are also directions for installing the AWS CLI; however, I eneded up using [these instructions](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html) to do so.  

After installing, **kubectl**, **kops**, and **aws** should be available bash commands.

### AWS Setup

* Create an AWS account and add credit card for billing.
* Create an IAM user with admin privledges. Record the aws\_access\_key\_id and the aws\_secret\_access\_key.
* Run **aws configure** to setup credentials.

##### Setup an S3 Bucket:
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

At this point, I noticed on my AWS EC2 dashboard, I had 3 instances running (1 master, 2 slaves), furthermore, I get can run the following:

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
kops delete cluster --name ${CLUSTER_NAME}
```

Note: This will delete the cluster configuration files in the S3 bucket. We will have to recreate the cluster configuration to build the cluster again (I'm sure there are flags to add to **kops delete** to prevent this).