resource "aws_eks_cluster" "k8s" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.subnet[*].id
  }
  
}
