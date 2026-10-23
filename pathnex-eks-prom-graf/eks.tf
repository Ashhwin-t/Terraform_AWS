resource "aws_eks_cluster" "pathnex" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = local.kubernetes_version

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    subnet_ids = local.subnet_ids

    endpoint_public_access  = true
    endpoint_private_access = true

    public_access_cidrs = [
      "0.0.0.0/0"
    ]
  }
  zonal_shift_config {
    enabled = false
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster]
}
