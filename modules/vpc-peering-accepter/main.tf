data "aws_caller_identity" "this" {}

data "aws_region" "this" {}


###################################################
# VPC Peering for Accepter
###################################################

resource "aws_vpc_peering_connection_accepter" "this" {
  vpc_peering_connection_id = var.id
  auto_accept               = true

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_vpc_peering_connection_options" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this.id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}
