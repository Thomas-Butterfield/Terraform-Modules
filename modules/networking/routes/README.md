<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_route.route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefix"></a> [address\_prefix](#input\_address\_prefix) | The destination CIDR to which the route applies, such as 10.1.0.0/16 | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the route. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_next_hop_in_ip_address"></a> [next\_hop\_in\_ip\_address](#input\_next\_hop\_in\_ip\_address) | Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance | `string` | `null` | no |
| <a name="input_next_hop_type"></a> [next\_hop\_type](#input\_next\_hop\_type) | The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None | `string` | `"None"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | The name of the route table within which create the route | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Route |
<!-- END_TF_DOCS -->