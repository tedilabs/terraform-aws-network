output "id" {
  description = "The ID of the DX Gateway."
  value       = aws_dx_gateway.this.id
}

output "name" {
  description = "The name of the DX Gateway."
  value       = aws_dx_gateway.this.name
}

output "asn" {
  description = "The ASN of the Amazon side of the connection."
  value       = aws_dx_gateway.this.amazon_side_asn
}

output "owner_account_id" {
  description = "AWS Account ID of the gateway."
  value       = aws_dx_gateway.this.owner_account_id
}

output "gateway_associations" {
  description = "Associated VGW or Transit gateway with a Direct Connect Gateway in same account."
  value       = aws_dx_gateway_association.this
}

output "cross_account_gateway_associations" {
  description = "Associated VGW or Transit gateway with a Direct Connect Gateway in cross account."
  value       = aws_dx_gateway_association.external
}
