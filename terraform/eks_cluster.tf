resource "aws_eks_cluster" "k8s" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.subnet[*].id
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy_attachment]

  tags = {
    Name = "${var.cluster_name}"

  }
}

# resource "aws_eks_addon" "aws-ebs-csi-driver" {
#   cluster_name             = var.cluster_name
#   addon_name               = "aws-ebs-csi-driver"
#   service_account_role_arn = aws_iam_role.eks_role.arn
#   depends_on               = [aws_eks_cluster.k8s]

# }

