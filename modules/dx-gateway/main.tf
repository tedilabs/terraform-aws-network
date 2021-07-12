locals {
  metadata = {
    package = "terraform-aws-network"
    version = trimspace(file("${path.module}/../../VERSION"))
    module  = basename(path.module)
    name    = var.name
  }
}

resource "aws_dx_gateway" "this" {
  name            = local.metadata.name
  amazon_side_asn = var.asn
}

resource "aws_dx_gateway_association" "this" {
  for_each = {
    for association in var.gateway_associations :
    association.gateway_id => association
  }

  dx_gateway_id = aws_dx_gateway.this.id

  associated_gateway_id = each.key
  allowed_prefixes      = try(each.value.allowed_prefixes, null)
}

resource "aws_dx_gateway_association" "external" {
  for_each = {
    for association in var.cross_account_gateway_associations :
    association.gateway_id => association
  }

  dx_gateway_id = aws_dx_gateway.this.id

  associated_gateway_owner_account_id = each.value.account_id
  proposal_id                         = each.value.proposal_id
  allowed_prefixes                    = try(each.value.allowed_prefixes, null)
}
