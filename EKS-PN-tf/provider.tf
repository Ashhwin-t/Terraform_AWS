terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    google = {
      source = "hashicorp/google"
      # Choose one version:
      version = "> 5.4.3"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "current" {
  name = "ashwin-eks"
}

provider "helm" {
  kubernetes = {
    host = data.aws_eks_cluster.current.endpoint
    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.current.certificate_authority[0].data
    )

    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"

      args = [
        "eks",
        "get-token",
        "--cluster-name",
        data.aws_eks_cluster.current.name,
        "--region",
        "ap-southeast-2"
      ]
    }
  }
}
