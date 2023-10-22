data "aws_region" "this" {}

locals {
  region = data.aws_region.this.name
}


###################################################
# IPAM
###################################################

module "ipam" {
  source  = "tedilabs/ipam/aws//modules/ipam"
  version = "~> 0.1.0"

  name        = "test"
  description = "Managed by Terraform."

  operating_regions = [local.region]

  tags = {
    "project" = "terraform-aws-network-examples"
  }
}


###################################################
# IPAM Pools
###################################################

resource "aws_vpc_ipam_pool" "ipv4" {
  address_family = "ipv4"
  ipam_scope_id  = module.ipam.default_scopes["private"]
  locale         = local.region
}

resource "aws_vpc_ipam_pool_cidr" "ipv4" {
  ipam_pool_id = aws_vpc_ipam_pool.ipv4.id
  cidr         = "10.20.0.0/16"

}

resource "aws_vpc_ipam_pool" "ipv6" {
  address_family        = "ipv6"
  ipam_scope_id         = module.ipam.default_scopes["public"]
  locale                = local.region
  publicly_advertisable = false
  public_ip_source      = "amazon"
  aws_service           = "ec2"
}

resource "aws_vpc_ipam_pool_cidr" "ipv6" {
  ipam_pool_id   = aws_vpc_ipam_pool.ipv6.id
  netmask_length = 52
}
