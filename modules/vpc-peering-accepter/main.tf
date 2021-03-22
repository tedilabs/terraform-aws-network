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
    account_id = aws_vpc_peering_connection_accepter.this.peer_owner_id
    region     = aws_vpc_peering_connection_accepter.this.peer_region
    vpc_id     = aws_vpc_peering_connection_accepter.this.peer_vpc_id
  }
  accepter = {
    account_id = data.aws_caller_identity.this.account_id
    region     = data.aws_region.this.name
    vpc_id     = aws_vpc_peering_connection_accepter.this.vpc_id
  }
}


###################################################
# VPC Peering for Accepter
###################################################

resource "aws_vpc_peering_connection_accepter" "this" {
  vpc_peering_connection_id = var.id
  auto_accept               = true

  tags = merge(
    {
      "Name" = local.metadata.name
    },
    local.module_tags,
    var.tags,
  )
}

resource "aws_vpc_peering_connection_options" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this.id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}
