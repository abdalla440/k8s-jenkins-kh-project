resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.k8s.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = aws_subnet.subnet[*].id

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]

  capacity_type = "SPOT"

  remote_access {
    ec2_ssh_key = var.ec2_key_pair_name
  }

  tags = {
    Name = "${var.node_group_name}"

  }

  depends_on = [
    aws_eks_cluster.k8s

    ]
}
