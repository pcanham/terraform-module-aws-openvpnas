provider "aws" {
  region                   = var.aws_region
  }

module "network" {
  source                = "git::https://github.com/pcanham/terraform-module-aws-vpc.git?ref=0.1.26"
  aws_region            = var.aws_region
  availability_zones    = var.availability_zones
  master_cidr_block     = var.master_cidr_block
  nat_gateway           = var.nat_gateway
  single_nat_gateway    = true
  public_cidr_blocks    = var.public_cidr_blocks
  private_cidr_blocks01 = var.private_cidr_blocks01
  private_cidr_blocks02 = var.private_cidr_blocks02
  private_cidr_blocks03 = var.private_cidr_blocks03

  tags = merge(
    local.common_tags,
    {
      "SERVICE" = "VPC"
    }
  )
  environment_tag = var.environment_tag
  project_tag     = var.project_tag
  k8s_clustername = null
}