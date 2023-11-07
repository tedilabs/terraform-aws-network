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

  name = "hello-world"

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
