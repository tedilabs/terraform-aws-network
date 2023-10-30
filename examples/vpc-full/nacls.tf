###################################################
# Network ACLs
###################################################

module "private_network_acl" {
  source = "../../modules/nacl"
  # source  = "tedilabs/network/aws//modules/nacl"
  # version = "~> 0.2.0"

  name    = "test-private"
  vpc_id  = module.vpc.id
  subnets = module.private_subnet_group.ids

  ingress_rules = {
    900 = {
      action    = "ALLOW"
      protocol  = "-1"
      ipv4_cidr = "10.0.0.0/16"
    }
  }
  egress_rules = {
    900 = {
      action    = "ALLOW"
      protocol  = "-1"
      ipv4_cidr = "10.0.0.0/16"
    }
  }

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}

module "public_network_acl" {
  source = "../../modules/nacl"
  # source  = "tedilabs/network/aws//modules/nacl"
  # version = "~> 0.2.0"

  name    = "test-public"
  vpc_id  = module.vpc.id
  subnets = module.public_subnet_group.ids

  ingress_rules = {
    100 = {
      action    = "ALLOW"
      protocol  = "icmp"
      ipv4_cidr = "0.0.0.0/0"
      icmp_type = -1
      icmp_code = -1
    }
    200 = {
      action    = "ALLOW"
      protocol  = "tcp"
      ipv4_cidr = "0.0.0.0/0"
      from_port = 22
      to_port   = 22
    }
    300 = {
      action    = "ALLOW"
      protocol  = "tcp"
      ipv4_cidr = "0.0.0.0/0"
      from_port = 80
      to_port   = 80
    }
    310 = {
      action    = "ALLOW"
      protocol  = "tcp"
      ipv4_cidr = "0.0.0.0/0"
      from_port = 443
      to_port   = 443
    }
    800 = {
      action    = "ALLOW"
      protocol  = "tcp"
      ipv4_cidr = "0.0.0.0/0"
      from_port = 1024
      to_port   = 65535
    }
    801 = {
      action    = "ALLOW"
      protocol  = "udp"
      ipv4_cidr = "0.0.0.0/0"
      from_port = 1024
      to_port   = 65535
    }
    900 = {
      action    = "ALLOW"
      protocol  = "-1"
      ipv4_cidr = "10.0.0.0/16"
    }
  }
  egress_rules = {
    900 = {
      action    = "ALLOW"
      protocol  = "-1"
      ipv4_cidr = "0.0.0.0/0"
    }
  }

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}
