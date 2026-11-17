resource "aws_eks_node_group" "ashwins-NG" {
  cluster_name    = aws_eks_cluster.ashwins-eks.name
  node_group_name = "ashwins-ng"

  node_role_arn = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    "subnet-07d0cde1f04933d8b",
    "subnet-0523875242dc48665",
    "subnet-06cc724722fb217e6"
  ]

  version        = "1.36"
  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]
  disk_size      = 20

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 4
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled"          = "true"
    "k8s.io/cluster-autoscaler/ashwins-eks" = "owned"
  }

  # lifecycle {
  #   ignore_changes = [
  #     scaling_config[0].desired_size
  #   ]
  # }



  update_config {
    max_unavailable = 1
    update_strategy = "DEFAULT"
  }

  remote_access {
    ec2_ssh_key = "ankitaws"

    source_security_group_ids = [
      "sg-014343e43cbecc019"
    ]
  }

  depends_on = [
  aws_iam_role_policy_attachment.eks_worker_node,
  aws_iam_role_policy_attachment.eks_cni,
  aws_iam_role_policy_attachment.eks_ecr
]
}
