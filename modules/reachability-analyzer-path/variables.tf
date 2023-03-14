variable "name" {
  description = "The name of the reachability analyzer path."
  type        = string
  nullable    = false
}

variable "protocol" {
  description = "The protocol to use for analysis. Valid values are `TCP` or `UDP`."
  type        = string
  default     = "TCP"
  nullable    = false

  validation {
    condition     = contains(["TCP", "UDP"], var.protocol)
    error_message = "Valid values for `protocol` are `TCP` or `UDP`."
  }
}

variable "source_network" {
  description = <<EOF
  (Required) The configuration of source network for analysis. `source_network` as defined below.
    (Required) `id` - The ID of resource which is the source of the path. Can be an Instance, Internet Gateway, Network Interface, Transit Gateway, VPC Endpoint, VPC Peering Connection or VPN Gateway.
    (Optional) `ip_address` - The IP address of the source resource.
  EOF
  type = object({
    id         = string
    ip_address = optional(string)
  })
  nullable = false
}

variable "destination_network" {
  description = <<EOF
  (Required) The configuration of destination network for analysis. `destination_network` as defined below.
    (Required) `id` - The ID of resource which is the destination of the path. Can be an Instance, Internet Gateway, Network Interface, Transit Gateway, VPC Endpoint, VPC Peering Connection or VPN Gateway.
    (Optional) `ip_address` - The IP address of the destination resource.
    (Optional) `port` - The port number of destination to analyze access to.
  EOF
  type = object({
    id         = string
    ip_address = optional(string)
    port       = optional(number)
  })
  nullable = false
}

variable "analyses" {
  description = <<EOF
  (Optional) The configuration of analyses to run with the reachability analyzer path. Each block of `analyses` as defined below.
    (Required) `name` - A name of the analysis with the reachability analyzer path.
    (Optional) `required_intermediate_components` - A list of ARNs for resources the path must traverse. Intermediate components include load balancers, NAT gateways, and peering connections. You cannot use security groups, network access control lists, network interfaces, or route tables as intermediate components.
    (Optional) `wait_for_completion` - Whether to wait for the analysis status to change to `succeeded` or `failed`. Setting this to `false` will skip the process. Defaults to `true`.
  EOF
  type = list(object({
    name = string

    required_intermediate_components = optional(list(string), [])
    wait_for_completion              = optional(bool, true)
  }))
  default  = []
  nullable = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "module_tags_enabled" {
  description = "Whether to create AWS Resource Tags for the module informations."
  type        = bool
  default     = true
  nullable    = false
}


###################################################
# Resource Group
###################################################

variable "resource_group_enabled" {
  description = "Whether to create Resource Group to find and group AWS resources which are created by this module."
  type        = bool
  default     = true
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of Resource Group. A Resource Group name can have a maximum of 127 characters, including letters, numbers, hyphens, dots, and underscores. The name cannot start with `AWS` or `aws`."
  type        = string
  default     = ""
  nullable    = false
}

variable "resource_group_description" {
  description = "The description of Resource Group."
  type        = string
  default     = "Managed by Terraform."
  nullable    = false
}
