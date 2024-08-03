cidr_block        = "10.0.0.0/16"
cluster_name      = "dino-cluster"
eks_role_name     = "dino-eks-role"
node_group_name   = "dino-node-group"
node_role_name    = "dino-node-role"
desired_size      = 2
max_size          = 3
min_size          = 1
instance_type     = "t2.medium"
ec2_key_pair_name = "dino-key-pair"

