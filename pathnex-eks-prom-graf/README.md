# Amazon EKS with Terraform

This project creates an Amazon EKS cluster and a managed EC2 node group using
Terraform. It is designed for classroom use and avoids account-specific subnet,
security-group, and IAM role IDs.

## What this project creates

- An Amazon EKS cluster
- One managed node group using Spot instances
- IAM roles and policy attachments for the cluster and worker nodes
- An IAM role and Pod Identity association for the EBS CSI driver
- EKS add-ons for CoreDNS, VPC CNI, kube-proxy, Pod Identity, metrics-server,
  ExternalDNS, and node monitoring

The configuration discovers the default VPC and its available subnets in each
student's AWS account through the data sources in `data.tf`.

## Prerequisites

Install and configure:

- Terraform 1.5 or newer
- AWS CLI
- `kubectl`
- An AWS account with permission to manage EKS, EC2, and IAM resources
- A default VPC containing subnets in at least two Availability Zones

Confirm that your AWS credentials work:

```bash
aws sts get-caller-identity
```

If your account does not have a default VPC, create one or change `data.tf` to
select an existing VPC and its subnets.

## Configuration

The values students normally change are in `terraform.tfvars`:

```hcl
aws_region   = "ap-south-1"
cluster_name = "Pathnex-Aug-2026"
```

All software versions are centralized in `versions.tf`, including:

- Terraform version
- AWS provider version
- Kubernetes version
- EKS add-on versions

Before deploying, confirm that the selected Kubernetes and add-on versions are
available in your AWS region. Also confirm that the configured EC2 instance type
in `nodegroup.tf` is offered there.

## Deploy

Initialize Terraform:

```bash
terraform init
```

Format and validate the configuration:

```bash
terraform fmt -check
terraform validate
```

Review the resources Terraform will create:

```bash
terraform plan
```

Create the cluster:

```bash
terraform apply
```

Enter `yes` only after reviewing the plan. EKS creation can take several
minutes.

## Connect with kubectl

After the apply completes, update your kubeconfig:

```bash
aws eks update-kubeconfig \
  --region ap-southeast-2 \
  --name Pathnex-Oct-2026
```

Use the same region and cluster name configured in `terraform.tfvars`.

Verify the cluster and nodes:

```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

## Project files

| File | Purpose |
| --- | --- |
| `versions.tf` | Terraform, provider, Kubernetes, and add-on versions |
| `variables.tf` | Input variable declarations and defaults |
| `terraform.tfvars` | Region and cluster-name overrides |
| `provider.tf` | AWS provider configuration |
| `data.tf` | Default VPC and subnet discovery |
| `eks.tf` | EKS control plane |
| `nodegroup.tf` | Managed worker-node group |
| `iam.tf` | IAM roles, policies, and Pod Identity association |
| `addons.tf` | Managed EKS add-ons |
| `imports.tf` | Commented examples for importing existing resources |

## Clean up

The cluster and its worker nodes incur AWS charges. Destroy the lab resources
when they are no longer required:

```bash
terraform plan -destroy
terraform destroy
```

Review the destroy plan carefully before entering `yes`.

## Important notes

- The node group uses Spot capacity, so AWS can interrupt and replace nodes.
- The Kubernetes API public endpoint currently allows `0.0.0.0/0`. For a
  production deployment, restrict `public_access_cidrs` in `eks.tf`.
- Terraform state can contain infrastructure details. Do not commit local state
  files or credentials to source control.
- Do not run multiple copies with the same cluster name in one AWS account and
  region.
