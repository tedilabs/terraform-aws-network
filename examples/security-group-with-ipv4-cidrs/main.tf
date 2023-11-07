provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}


###################################################
# Security Group
###################################################

module "security_group" {
  source = "../../modules/security-group"
  # source  = "tedilabs/ipam/aws//modules/security-group"
  # version = "~> 0.30.0"

  vpc_id = data.aws_vpc.default.id

  name        = "hello-world-ipv4-cidrs"
  description = "Sample Security Group with IPv4 CIDRs."

  revoke_rules_on_delete = true

  ingress_rules = [
    {
      id          = "tcp/80"
      description = "Allow HTTP from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      ipv4_cidrs  = ["192.168.0.0/16", "10.0.0.0/8", "172.168.0.0/24"]
    },
  ]
  egress_rules = [
    {
      id          = "all/all"
      description = "Allow all traffics to the internet"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      ipv4_cidrs  = ["0.0.0.0/0"]
    },
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
