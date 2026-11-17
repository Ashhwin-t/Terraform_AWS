resource "aws_eks_cluster" "ashwins-eks" {
  name     = "ashwin-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.36"

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

  vpc_config {
    subnet_ids = [
      "subnet-07d0cde1f04933d8b",
      "subnet-0523875242dc48665",
      "subnet-06cc724722fb217e6"
  ]
  
    security_group_ids = [
      "sg-014343e43cbecc019"
    ]

    endpoint_public_access  = true
    endpoint_private_access = true

    public_access_cidrs = [
      "0.0.0.0/0"
    ]
  }
  zonal_shift_config {
    enabled = false
  }
  depends_on = [
  aws_iam_role_policy_attachment.eks_cluster_policy
]
}
