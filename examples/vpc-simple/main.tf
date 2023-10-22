provider "aws" {
  region = "us-east-1"
}


###################################################
# VPC
###################################################

module "vpc" {
  source = "../../modules/vpc"
  # source  = "tedilabs/network/aws//modules/vpc"
  # version = "~> 0.2.0"

  name = "test"
  ipv4_cidrs = [
    {
      cidr = "10.0.0.0/16"
    },
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
