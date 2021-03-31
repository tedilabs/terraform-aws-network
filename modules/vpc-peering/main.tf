locals {
  metadata = {
    package = "terraform-aws-network"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
  module_tags = var.module_tags_enabled ? {
    "module.terraform.io/package"   = local.metadata.package
    "module.terraform.io/version"   = local.metadata.version
    "module.terraform.io/name"      = local.metadata.module
    "module.terraform.io/full-name" = "${local.metadata.package}/${local.metadata.module}"
    "module.terraform.io/instance"  = local.metadata.name
  } : {}
}

data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

data "aws_vpc" "requester" {
  id = var.requester_vpc_id
}

data "aws_vpc" "accepter" {
  id = var.accepter_vpc_id
}

locals {
  requester = {
    account_id = data.aws_caller_identity.this.account_id
    region     = data.aws_region.this.name
    vpc_id     = var.requester_vpc_id
    cidr_block = data.aws_vpc.requester.cidr_block
    secondary_cidr_blocks = [
      for association in data.aws_vpc.requester.cidr_block_associations :
      association.cidr_block
      if association.cidr_block != data.aws_vpc.requester.cidr_block
    ]
  }
  accepter = {
    account_id = data.aws_caller_identity.this.account_id
    region     = data.aws_region.this.name
    vpc_id     = var.accepter_vpc_id
    cidr_block = data.aws_vpc.accepter.cidr_block
    secondary_cidr_blocks = [
      for association in data.aws_vpc.accepter.cidr_block_associations :
      association.cidr_block
      if association.cidr_block != data.aws_vpc.accepter.cidr_block
    ]
  }
}


###################################################
# VPC Peering
###################################################

resource "aws_vpc_peering_connection" "this" {
  vpc_id      = local.requester.vpc_id
  peer_vpc_id = local.accepter.vpc_id
  auto_accept = true

  requester {
    allow_remote_vpc_dns_resolution = var.requester_allow_remote_vpc_dns_resolution
  }

  accepter {
    allow_remote_vpc_dns_resolution = var.accepter_allow_remote_vpc_dns_resolution
  }

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}
