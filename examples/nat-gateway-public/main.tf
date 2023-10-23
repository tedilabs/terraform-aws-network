provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


###################################################
# Elastic IP
###################################################

module "elastic_ip" {
  source  = "tedilabs/ipam/aws//modules/elastic-ip"
  version = "~> 0.3.0"

  name = "nat-gw-public"
  type = "AMAZON"

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}


###################################################
# Public NAT Gateway
###################################################

module "nat_gateway" {
  source = "../../modules/nat-gateway"
  # source  = "tedilabs/network/aws//modules/nat-gateway"
  # version = "~> 0.2.0"

  name       = "test/az1"
  is_private = false
  subnet     = data.aws_subnets.default.ids[0]


  ## Primary IP Address
  primary_ip_assignment = {
    elastic_ip = module.elastic_ip.id
  }


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
