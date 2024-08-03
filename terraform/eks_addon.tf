resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name                = var.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  service_account_role_arn    = aws_iam_role.eks_role.arn
}