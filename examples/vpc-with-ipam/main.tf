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
      type = "IPAM_POOL"
      ipam_pool = {
        id             = aws_vpc_ipam_pool.ipv4.id
        netmask_length = 28
      }
    },
    {
      cidr = "10.0.0.0/16"
    },
    {
      type = "IPAM_POOL"
      ipam_pool = {
        id             = aws_vpc_ipam_pool.ipv4.id
        netmask_length = 28
      }
    },
  ]
  ipv6_cidrs = [
    {
      type = "AMAZON"
    },
    {
      type = "IPAM_POOL"
      ipam_pool = {
        id             = aws_vpc_ipam_pool.ipv6.id
        netmask_length = 56
      }
    },
    {
      type = "IPAM_POOL"
      ipam_pool = {
        id   = aws_vpc_ipam_pool.ipv6.id
        cidr = "2600:1f28:7f:4100::/56"
      }
    },
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }

  depends_on = [
    aws_vpc_ipam_pool_cidr.ipv4,
    aws_vpc_ipam_pool_cidr.ipv6,
  ]
}
