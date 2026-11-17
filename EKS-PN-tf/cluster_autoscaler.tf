resource "helm_release" "cluster_autoscaler" {
  name      = "cluster-autoscaler"
  namespace = "kube-system"

  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = aws_eks_cluster.ashwins-eks.name
      }

      awsRegion     = "ap-southeast-2"
      cloudProvider = "aws"

      rbac = {
        serviceAccount = {
          create = true
          name   = "cluster-autoscaler"
        }
      }
    })
  ]

  depends_on = [
    aws_eks_pod_identity_association.cluster_autoscaler
  ]
}
