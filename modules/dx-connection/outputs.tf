output "id" {
  description = "The ID of the DX connection."
  value       = aws_dx_connection.this.id
}

output "arn" {
  description = "The ARN of the DX connection."
  value       = aws_dx_connection.this.arn
}

output "name" {
  description = "The name of the DX connection."
  value       = aws_dx_connection.this.name
}

output "aws_device" {
  description = "The Direct Connect endpoint on which the physical connection terminates."
  value       = aws_dx_connection.this.aws_device
}

output "bandwidth" {
  description = "The bandwidth of the DX connection."
  value       = aws_dx_connection.this.bandwidth
}

output "vlan" {
  description = "The ID of the VLAN."
  value       = aws_dx_connection.this.vlan_id
}

output "jumbo_frame_capable" {
  description = "Whether jumbo frames (9001 MTU) are supported."
  value       = aws_dx_connection.this.jumbo_frame_capable
}

output "logical_redundancy_capable" {
  description = "Indicate whether the connection supports a secondary BGP peer in the same address family (IPv4/IPv6)."
  value       = aws_dx_connection.this.has_logical_redundancy != "no"
}

output "location" {
  description = <<EOF
  The information of the AWS Direct Connect location where the connection is located.
  EOF
  value = {
    id   = data.aws_dx_location.this.id
    code = data.aws_dx_location.this.location_code
    name = data.aws_dx_location.this.location_name

    available_providers         = data.aws_dx_location.this.available_providers
    available_bandwidths        = data.aws_dx_location.this.available_port_speeds
    available_macsec_bandwidths = data.aws_dx_location.this.available_macsec_port_speeds
  }
}

output "service_provider" {
  description = "The name of the service provider associated with the connection."
  value       = aws_dx_connection.this.provider_name
}

output "encryption" {
  description = <<EOF
  The configuration for MACsec encryption of the AWS Direct Connect connection.
    `macsec_capable` - Whether the connection supports MAC Security (MACsec).
    `mode` - The connection MAC Security (MACsec) encryption mode.
    `status` - The MAC Security (MACsec) port link status of the connection.
  EOF
  value = {
    macsec_capable = aws_dx_connection.this.macsec_capable
    mode           = var.encryption.mode
    status         = aws_dx_connection.this.port_encryption_status
  }
}
