# terraform-aws-eks-cluster

### Preface
This project is designed to be an example of standing up an EKS Cluster from scratch.  It is not intended for production use, but with some minor modifications can be configured to be production ready.  Removing the VPC definition(or keeping it!), and reconfiguring the Spot Fleet to use larger instances as well as autoscaling would make it more akin to a production cluster.

### Pre-requisites
* Terraform Version 0.11.8 installed
* AWS Account
* Terraform user created in account with Admin permissions
* S3 Bucket created for storing state
* Dynamodb table created for locking state

### Configuration

This project is a kitchen sink project.  It have every component required for standing up an EKS Cluster, it includes:
* Creating a VPC with:
  * 3 private subnets
  * 3 public subnets
  * NAT Gateway
  * Internet Gateway
* Creates an EKS Master Cluster with all required IAM Permissions
* Creates a Spot Fleet with Userdata configured to automatically join nodes to EKS

All that is necessary is to modify your the cluster name and a the allowed inbound IP address variables.  The IP variable is intended to whitelist your IP address for connecting to the new cluster.  Other modifications can be made to subnet IP allocations and names as necessary.

Once the necessary variables have been updated, run the following command:

```bash
$ terraform init
$ terraform apply
```

After this completes you will have two outputs, _config-map-aws-auth_ and _kubconfig_.  Place the kubeconfig in your __$HOME/.kube/config__.  Verify that you can connect to the newly created cluster by running:
```bash
$ kubectl cluster-info
```

You should see a message similar to the following:
```bash
Kubernetes master is running at https://BDBC3C10C30CE483C169F0D7B932DEBC.yl4.us-east-1.eks.amazonaws.com
```

After you've verified that the cluster is running save the output labeled _config-map-aws-auth_ to _config-map-aws-auth.yaml_.  Then run the following command against it:

```bash
$ kubectl -f apply config-map-aws-auth.yaml
```
Finally run:
```bash
$ kubectl get-nodes --watch
```

And you should see the worker nodes joining the cluster.

#Cleaning Up
The EKS master node is pretty expensive so I recommend not running it all the time unless you have a lot of cash to burn.  When you're finished experimenting simply run:
```bash
$ terraform destroy
```

This will delete and cleanup all the resources created by this project.