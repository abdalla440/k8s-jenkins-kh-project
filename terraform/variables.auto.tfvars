cidr_block       = "10.0.0.0/16"
cluster_name     = "dino-cluster"
eks_role_name    = "eks-role"
node_group_name  = "node-group"
node_role_name   = "node-role"
desired_size     = 2
max_size         = 3
min_size         = 1
instance_type    = "t3.micro"
ec2_key_pair_name = "dino-key-pair"

