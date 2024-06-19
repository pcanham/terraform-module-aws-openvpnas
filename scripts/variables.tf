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

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
  default     = ""
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
