data "aws_caller_identity" "this" {}

data "aws_region" "this" {}

locals {
  requester = {
    id     = data.aws_caller_identity.this.account_id
    region = data.aws_region.this.name
    vpc_id = var.vpc_id
  }
  accepter = {
    id     = var.accepter_id
    region = var.accepter_region
    vpc_id = var.accepter_vpc_id
  }
}


###################################################
# VPC Peering for Requester
###################################################

resource "aws_vpc_peering_connection" "this" {
  vpc_id      = local.requester.vpc_id
  auto_accept = false

  peer_owner_id = local.accepter.id
  peer_region   = local.accepter.region
  peer_vpc_id   = var.accepter.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
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
