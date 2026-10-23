terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

locals {
  kubernetes_version = "1.35"

  addon_versions = {
    ebs_csi         = "v1.63.1-eksbuild.1"
    coredns         = "v1.14.3-eksbuild.3"
    node_monitoring = "v1.7.0-eksbuild.1"
    pod_identity    = "v1.3.10-eksbuild.3"
    external_dns    = "v0.21.0-eksbuild.6"
    kube_proxy      = "v1.35.3-eksbuild.13"
    metrics_server  = "v0.9.0-eksbuild.5"
    vpc_cni         = "v1.22.4-eksbuild.3"
  }
}
