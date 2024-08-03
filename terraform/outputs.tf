output "vpc_id" {
  value = aws_vpc.dino-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnet[*].id
}

  output "cluster_name" {
    value = aws_eks_cluster.k8s.name
  }

  output "cluster_endpoint" {
    value = aws_eks_cluster.k8s.endpoint
  }

  output "cluster_role_arn" {
    value = aws_iam_role.eks_role.arn
  }
 