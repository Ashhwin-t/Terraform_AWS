# pathnex-eks-tf
This will create kubernetes cluster

Kindly change variable things like Account ID, VPC, Security Group.

Video to follow - https://www.youtube.com/live/cG-0doSFUTU?si=wSC_rmqClBQ7Te67

### Important Guidelines
1. If run below command to update helm repo before terraform plan
```bash
helm repo update
```
2. If **AmazonEKSNodeRole** and **AmazonEKSClusterRole** are already created in your AWS account then comment entire **cluster_autoscaler.tf** file , **data block and provider "helm" block in provider.tf file**. Once cluster is created then uncomment them ant do terraform apply