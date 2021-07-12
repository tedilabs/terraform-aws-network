variable "name" {
  description = "Desired name for the DX Gateway resources."
  type        = string
}

variable "asn" {
  description = "The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294."
  type        = number
}

variable "gateway_associations" {
  description = "The configurations to associate VPN Gateway or Transit Gateway with a Direct Connect Gateway in same account."
  type        = list(any)
  default     = []
}

variable "cross_account_gateway_associations" {
  description = "The configurations to associate VPN Gateway or Transit Gateway with a Direct Connect Gateway in cross account."
  type        = list(any)
  default     = []
}
