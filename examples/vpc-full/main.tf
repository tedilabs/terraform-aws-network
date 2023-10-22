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
  ipv6_cidrs = [
    {
      type = "AMAZON"
    },
  ]


  ## DHCP Option Set
  dhcp_options = {
    enabled             = true
    domain_name         = "example.com"
    domain_name_servers = ["4.4.4.4", "8.8.8.8"]
  }


  ## Gateways
  internet_gateway = {
    enabled = true
  }
  egress_only_internet_gateway = {
    enabled = true
  }
  vpn_gateway = {
    enabled = true
  }


  ## Defaults
  default_network_acl = {
    name = "test-default"
    ingress_rules = [
      {
        priority  = 200
        action    = "ALLOW"
        protocol  = "tcp"
        from_port = 443
        to_port   = 443
        ipv4_cidr = "0.0.0.0/0"
      },
      {
        priority  = 201
        action    = "ALLOW"
        protocol  = "tcp"
        from_port = 443
        to_port   = 443
        ipv6_cidr = "::/0"
      },
    ]
  }
  default_security_group = {
    name = "test-default"
    ingress_rules = [
      {
        protocol   = "tcp"
        from_port  = 80
        to_port    = 80
        ipv4_cidrs = ["10.0.0.0/16"]
      },
      {
        protocol  = "tcp"
        from_port = 443
        to_port   = 443
        self      = true
      },
    ]
    egress_rules = [
      {
        protocol   = "all"
        from_port  = 0
        to_port    = 0
        ipv4_cidrs = ["0.0.0.0/0"]
        ipv6_cidrs = ["::/0"]
      }
    ]
  }


  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
