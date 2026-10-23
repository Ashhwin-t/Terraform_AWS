resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "coredns"
  addon_version = local.addon_versions.coredns
  depends_on    = [aws_eks_cluster.pathnex]
}

resource "aws_eks_addon" "node_monitoring" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "eks-node-monitoring-agent"
  addon_version = local.addon_versions.node_monitoring
  depends_on    = [aws_eks_cluster.pathnex]
}

resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = local.addon_versions.pod_identity
  depends_on    = [aws_eks_cluster.pathnex]
}

resource "aws_eks_addon" "external_dns" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "external-dns"
  addon_version = local.addon_versions.external_dns
  depends_on    = [aws_eks_cluster.pathnex]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "kube-proxy"
  addon_version = local.addon_versions.kube_proxy
  depends_on    = [aws_eks_cluster.pathnex]
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "metrics-server"
  addon_version = local.addon_versions.metrics_server
  depends_on    = [aws_eks_cluster.pathnex]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.pathnex.name
  addon_name    = "vpc-cni"
  addon_version = local.addon_versions.vpc_cni
  depends_on    = [aws_eks_cluster.pathnex]
}
