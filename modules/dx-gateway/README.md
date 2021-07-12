# dx-gateway

This module creates following resources.

- `aws_dx_gateway`
- `aws_dx_gateway_association` (optional)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dx_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway) | resource |
| [aws_dx_gateway_association.external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association) | resource |
| [aws_dx_gateway_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dx_gateway_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asn"></a> [asn](#input\_asn) | The ASN to be configured on the Amazon side of the connection. The ASN must be in the private range of 64,512 to 65,534 or 4,200,000,000 to 4,294,967,294. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Desired name for the DX Gateway resources. | `string` | n/a | yes |
| <a name="input_cross_account_gateway_associations"></a> [cross\_account\_gateway\_associations](#input\_cross\_account\_gateway\_associations) | The configurations to associate VPN Gateway or Transit Gateway with a Direct Connect Gateway in cross account. | `list(any)` | `[]` | no |
| <a name="input_gateway_associations"></a> [gateway\_associations](#input\_gateway\_associations) | The configurations to associate VPN Gateway or Transit Gateway with a Direct Connect Gateway in same account. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asn"></a> [asn](#output\_asn) | The ASN of the Amazon side of the connection. |
| <a name="output_cross_account_gateway_associations"></a> [cross\_account\_gateway\_associations](#output\_cross\_account\_gateway\_associations) | Associated VGW or Transit gateway with a Direct Connect Gateway in cross account. |
| <a name="output_gateway_associations"></a> [gateway\_associations](#output\_gateway\_associations) | Associated VGW or Transit gateway with a Direct Connect Gateway in same account. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the DX Gateway. |
| <a name="output_name"></a> [name](#output\_name) | The name of the DX Gateway. |
| <a name="output_owner_account_id"></a> [owner\_account\_id](#output\_owner\_account\_id) | AWS Account ID of the gateway. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
