provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

###################################################
# Reachability Analyzer
###################################################

module "reachability_analyzer_path__success" {
  source = "../../modules/reachability-analyzer-path"
  # source  = "tedilabs/network/aws//modules/reachability-analyzer-path"
  # version = "~> 0.26.0"

  name = "test-success"

  protocol = "TCP"
  source_network = {
    id = data.aws_internet_gateway.default.internet_gateway_id
  }
  destination_network = {
    id         = module.instance.id
    ip_address = module.instance.network.private_ip
  }

  analyses = [
    {
      name = "analysis-01"
    }
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "reachability_analyzer_path__fail" {
  source = "../../modules/reachability-analyzer-path"
  # source  = "tedilabs/network/aws//modules/reachability-analyzer-path"
  # version = "~> 0.26.0"

  name = "test-fail"

  protocol = "TCP"
  source_network = {
    id = data.aws_internet_gateway.default.internet_gateway_id
  }
  destination_network = {
    id         = module.instance.id
    ip_address = module.instance.network.private_ip
    port       = 22
  }

  analyses = [
    {
      name = "analysis-01"
    }
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}


###################################################
# EC2 Instance
###################################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

module "security_group" {
  source = "../../modules/security-group"
  # source  = "tedilabs/network/aws//modules/security-group"
  # version = "~> 0.26.0"

  name = "reachability-analyzer-test"

  vpc_id = data.aws_vpc.default.id

  ingress_rules = [
    {
      id          = "http/all"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      id          = "all/all"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "instance" {
  source  = "tedilabs/ec2/aws//modules/instance"
  version = "~> 0.2.0"

  name = "reachability-analyzer-test"
  type = "t2.micro"
  ami  = data.aws_ami.ubuntu.image_id

  security_groups = [module.security_group.id]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
