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
# Public NAT Gateway
###################################################

module "nat_gateway" {
  source = "../../modules/nat-gateway"
  # source  = "tedilabs/network/aws//modules/nat-gateway"
  # version = "~> 0.2.0"

  name       = "test-count"
  is_private = true
  subnet     = data.aws_subnets.default.ids[0]


  ## Primary IP Address
  primary_ip_assignment = {
    # Automatically assign a public IP address to the NAT Gateway
    private_ip = null
  }


  ## Secondary IP Addresses
  secondary_ip_count = 7


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "nat_gateway_2" {
  source = "../../modules/nat-gateway"
  # source  = "tedilabs/network/aws//modules/nat-gateway"
  # version = "~> 0.2.0"

  name       = "test-assingments"
  is_private = true
  subnet     = data.aws_subnets.default.ids[0]


  ## Primary IP Address
  primary_ip_assignment = {
    # Automatically assign a public IP address to the NAT Gateway
    private_ip = "172.31.51.100"
  }


  ## Secondary IP Addresses
  secondary_ip_assignments = [
    {
      private_ip = "172.31.51.101"
    },
    {
      private_ip = "172.31.51.102"
    },
    {
      private_ip = "172.31.51.103"
    },
    {
      private_ip = "172.31.51.104"
    },
  ]


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
