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

locals {
  requester = {
    account_id = data.aws_caller_identity.this.account_id
    region     = data.aws_region.this.name
    vpc_id     = var.vpc_id
  }
  accepter = {
    account_id = var.accepter_account_id != null ? var.accepter_account_id : local.requester.account_id
    region     = var.accepter_region != null ? var.accepter_region : local.requester.region
    vpc_id     = var.accepter_vpc_id
  }
}


###################################################
# VPC Peering for Requester
###################################################

resource "aws_vpc_peering_connection" "this" {
  vpc_id      = local.requester.vpc_id
  auto_accept = false

  peer_vpc_id   = local.accepter.vpc_id
  peer_region   = local.accepter.region
  peer_owner_id = local.accepter.account_id

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_vpc_peering_connection_options" "this" {
  count = var.allow_remote_vpc_dns_resolution ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

data "aws_vpc_peering_connection" "this" {
  id = aws_vpc_peering_connection.this.id
}
