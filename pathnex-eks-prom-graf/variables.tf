variable "aws_region" {
  description = "AWS region in which to create the EKS cluster."
  type        = string
  default     = "ap-southeast-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "Pathnex-Oct-2026"
}
