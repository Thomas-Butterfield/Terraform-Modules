# Express Route Circuit Peering

## Example Settings
```yaml
networking:
  express_route_circuit_peerings:
    ercpeer1:
      enabled: true
      resource_group_key: "networking"
      er_circuit_key: "ercircuit1"
      peering_type: "AzurePublicPeering"
      primary_peer_address_prefix: "123.0.0.0/30"
      secondary_peer_address_prefix: "123.0.0.4/30"
      vlan_id: 300
      peer_asn: 100
      shared_key: "safest_shared_key_ever!"
```

## Example Module Reference

```yaml
module "express_route_circuit_peerings" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/express_route_circuit_peering"
  for_each = {
    for key, value in try(local.settings.networking.express_route_circuit_peerings, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings            = local.settings
  resource_group_name        = try(each.value.rg_name, null) != null ? each.value.rg_name : try(each.value.resource_group_key, null) != null ? local.resource_groups[each.value.resource_group_key].name : null
  settings                   = each.value
  express_route_circuit_name = try(module.express_route_circuits[each.value.er_circuit_key].name, null)
}
```

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
| [azurerm_express_route_circuit_peering.er_circuit_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_circuit_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_express_route_circuit_name"></a> [express\_route\_circuit\_name](#input\_express\_route\_circuit\_name) | The name of the ExpressRoute Circuit in which to create the Peering | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Express Route Circuit Peering resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_asn"></a> [azure\_asn](#output\_azure\_asn) | The ASN used by Azure |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Express Route Circuit Peering |
| <a name="output_primary_azure_port"></a> [primary\_azure\_port](#output\_primary\_azure\_port) | The Primary Port used by Azure for this Peering |
| <a name="output_secondary_azure_port"></a> [secondary\_azure\_port](#output\_secondary\_azure\_port) | The Secondary Port used by Azure for this Peering |
<!-- END_TF_DOCS -->