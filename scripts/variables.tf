variable "aws_region" {
  type        = string
  description = "AWS region to launch servers."
}

variable "availability_zones" {
  type        = list(string)
  description = "AWS region to launch servers."
}

variable "master_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

variable "nat_gateway" {
  type        = bool
  description = "Create NAT Gateway"
  default     = false
}

variable "public_cidr_blocks" {
  type        = list(string)
  description = "CIDR Blocks for Public Subnets"
}

variable "private_cidr_blocks01" {
  type        = list(string)
  description = "CIDR Blocks for Private Subnets"
}

variable "private_cidr_blocks02" {
  type        = list(string)
  description = "CIDR Blocks for Private Subnets"
}

variable "private_cidr_blocks03" {
  type        = list(string)
  description = "CIDR Blocks for Private Subnets"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "environment_tag" {
  type        = string
  description = "Define the type of environment"
}

variable "project_tag" {
  type        = string
  description = "Project code name or name"
}

variable "public_tier_name" {
  type        = string
  description = "Tag value for name of subnet tier"
}

variable "private01_tier_name" {
  type        = string
  description = "Tag value for name of subnet tier"
}

variable "private02_tier_name" {
  type        = string
  description = "Tag value for name of subnet tier"
}

variable "private03_tier_name" {
  type        = string
  description = "Tag value for name of subnet tier"
}

variable "k8s_clustername" {
  type        = string
  description = "EKS/k8s Cluster Name"
}
