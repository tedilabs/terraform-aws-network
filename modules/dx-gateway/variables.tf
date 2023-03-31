variable "name" {
  description = "(Required) Desired name for the DX Gateway resources."
  type        = string
  nullable    = false
}

variable "asn" {
  description = "(Required) The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294."
  type        = number
  nullable    = false
}

variable "gateway_associations" {
  description = <<EOF
  (Optional) The configuration to associate a list of VPN Gateway or Transit Gateway with a Direct Connect Gateway in same account. Each block of `gateway_associations` as defined below.
    (Required) `gateway_id` - The ID of the VPN Gateway or Transit Gateway with which to associate. Used for single account Direct Connect gateway associations.
    (Optional) `allowed_prefixes` - A list of VPC prefixes (CIDRs) to advertise to the Direct Connect gateway. Defaults to the CIDR block of the VPC associated with the Virtual Gateway. To enable drift detection, must be configured.
  EOF
  type = list(object({
    gateway_id       = string
    allowed_prefixes = optional(list(string), [])
  }))
  default  = []
  nullable = false
}

variable "cross_account_gateway_associations" {
  description = <<EOF
  (Optional) The configuration to associate a list of VPN Gateway or Transit Gateway with a Direct Connect Gateway in cross account. Each block of `cross_account_gateway_associations` as defined below.
    (Required) `account_id` - The ID of the AWS account that owns the Virtual Private Gateway or Transit Gateway.
    (Required) `proposal_id` - The ID of the request proposal.
    (Optional) `allowed_prefixes` - A list of VPC prefixes (CIDRs) to advertise to the Direct Connect gateway. Defaults to the CIDR block of the VPC associated with the Virtual Gateway. To enable drift detection, must be configured.
  EOF
  type = list(object({
    account_id       = string
    proposal_id      = string
    allowed_prefixes = optional(list(string), [])
  }))
  default  = []
  nullable = false
}
