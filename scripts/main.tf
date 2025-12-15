provider "aws" {
  region = var.aws_region
}

module "network" {
  source                = "git::https://github.com/pcanham/terraform-module-aws-vpc.git?ref=1.0.0"
  aws_region            = var.aws_region
  availability_zones    = var.availability_zones
  master_cidr_block     = var.master_cidr_block
  nat_gateway           = var.nat_gateway
  single_nat_gateway    = true
  public_cidr_blocks    = var.public_cidr_blocks
  private_cidr_blocks01 = var.private_cidr_blocks01
  private_cidr_blocks02 = var.private_cidr_blocks02
  private_cidr_blocks03 = var.private_cidr_blocks03
  public_tier_name      = var.public_tier_name
  private01_tier_name   = var.private01_tier_name
  private02_tier_name   = var.private02_tier_name
  private03_tier_name   = var.private03_tier_name

  tags = merge(
    var.tags,
    {
      "SERVICE" = "VPC"
    }
  )
  k8s_clustername = var.k8s_clustername
}

resource "aws_route53_zone" "primary" {
  name = "example.com"
}
