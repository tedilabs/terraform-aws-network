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

  name       = "test/az1"
  is_private = true
  subnet     = data.aws_subnets.default.ids[0]


  ## Primary IP Address
  primary_ip_assignment = {
    # Automatically assign a public IP address to the NAT Gateway
    private_ip = null
  }


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
