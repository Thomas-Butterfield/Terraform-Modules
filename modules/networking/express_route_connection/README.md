# Express Route Connection

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{expressrouteconnection}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-ERC-001
```

## Example Settings
```yaml
networking:
  ## NOTE: VHub ER Connection will not work unless it is provisioned by vendor
  express_route_connections:
    erconn1:
      enabled: true
      naming_convention:
        postfix: "001"
      er_circuit_peering_key: "ercpeer1"
      #require both keys below to tie back to VWAN/VHUB ER Gateway
      vhub_key: "vhub1"
      vwan_key: "vwan1"
```

## Example Module Reference

```yaml
module "express_route_connections" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/express_route_connection"
  for_each = {
    for key, value in try(local.settings.networking.express_route_connections, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings                  = local.settings
  settings                         = each.value
  express_route_circuit_peering_id = try(module.express_route_circuit_peerings[each.value.er_circuit_peering_key].id, null)
  express_route_gateway_id         = try(local.virtual_wans[each.value.vwan_key].virtual_hubs[each.value.vhub_key].er_gateway.id, null)
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_connection.er_conn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_express_route_circuit_peering_id"></a> [express\_route\_circuit\_peering\_id](#input\_express\_route\_circuit\_peering\_id) | The ID of the Express Route Circuit Peering that this Express Route Connection connects with | `string` | n/a | yes |
| <a name="input_express_route_gateway_id"></a> [express\_route\_gateway\_id](#input\_express\_route\_gateway\_id) | The ID of the Express Route Gateway that this Express Route Connection connects with | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Express Route Connection resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Express Route Connection |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Express Route Connection |
<!-- END_TF_DOCS -->