variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "eks_role_name" {
  description = "The name of the EKS role"
  type        = string
}

variable "node_group_name" {
  description = "The name of the node group"
  type        = string
}

variable "node_role_name" {
  description = "The name of the node role"
  type        = string
}

variable "desired_size" {
  description = "The desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "The maximum number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "The minimum number of worker nodes"
  type        = number
}

variable "instance_type" {
  description = "The instance type for the worker nodes"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "The name of the SSH key pair for the worker nodes"
  type        = string
}
