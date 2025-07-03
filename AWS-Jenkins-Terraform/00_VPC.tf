provider "aws" {
  region = var.region
}

# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "eks-vpc"
  cidr    = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name = "eks-vpc"
  }
}
