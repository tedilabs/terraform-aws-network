provider "aws" {
  region = "us-east-1"
}


###################################################
# Prefix List
###################################################

module "ipv4" {
  source = "../../modules/prefix-list"
  # source  = "tedilabs/network/aws//modules/prefix-list"
  # version = "~> 0.26.0"

  name           = "test-ipv4"
  address_family = "IPv4"

  entries = [
    {
      cidr        = "10.1.2.3/32"
      description = "my server 1"
    },
    {
      cidr = "10.1.2.4/32"
    },
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "ipv6" {
  source = "../../modules/prefix-list"
  # source  = "tedilabs/network/aws//modules/prefix-list"
  # version = "~> 0.26.0"

  name           = "test-ipv6"
  address_family = "IPv6"

  entries = [
    {
      cidr        = "2001:0db8:85a3:0000:0000:8a2e:0370:7334/128"
      description = "my server 1"
    },
    {
      cidr = "2001:db8:85a3::/64"
    },
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
