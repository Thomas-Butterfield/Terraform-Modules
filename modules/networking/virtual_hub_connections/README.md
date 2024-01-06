# Virtual Hub Connection

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vhub}{delimiter}{vnet_address_space}{delimiter}Conn{postfix}"

Example Result: AVA-EUS2-DEV-VHUB-10_50_100_0_16-Conn001
```

## Example Settings
```yaml
# Settings below will automatically associated the VNet to the defaultRouteTable as well as propagate to the defaultRouteTable
networking:
  virtual_hub_connections:
    vhubconn1:
      enabled: true
      vwan_key: "vwan1data"
      vhub_key: "vhub1data"
      vnet_key: "vnet1"
      internet_security_enabled: true
      naming_convention:
        postfix: "001"

# Alternative settings below will associate the VNet to the specified custom route table via resource ID as well as propagate to the specified route table. This scenario is preferred for Zero Trust routing
networking:
  virtual_hub_connections:
    vhubconn1:
      enabled: true
      vwan_key: "vwan1data"
      vhub_key: "vhub1data"
      vnet_key: "vnet1"
      naming_convention:
        postfix: "001"
      internet_security_enabled: true
      assoc_to_custom_route_table: true
      assoc_route_table_resource_id: "/subscriptions/SUBSCRIPTION_ID_VALUE/resourceGroups/CONNECT-EUS2-DEV-NETWORK-RG/providers/Microsoft.Network/virtualHubs/CONNECT-EUS2-DEV-VHUB-01/hubRouteTables/ZeroTrust"
      prop_route_table_resource_ids: ["/subscriptions/SUBSCRIPTION_ID_VALUE/resourceGroups/CONNECT-EUS2-DEV-NETWORK-RG/providers/Microsoft.Network/virtualHubs/CONNECT-EUS2-DEV-VHUB-01/hubRouteTables/noneRouteTable"]      
```

## Example Module Reference

```yaml
module "virtual_hub_connection" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_hub_connections"
  providers = {
    azurerm               = azurerm
    azurerm.vhub_provider = azurerm.hub_subscription
  }
  for_each = {
    for key, value in try(local.settings.networking.virtual_hub_connections, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings = local.settings
  vhub_connection = each.value
  virtual_hub         = local.virtual_wans[each.value.vwan_key].virtual_hubs[each.value.vhub_key]
  virtual_network_id  = module.networking[each.value.vnet_key].id
  vnet_address_space  = module.networking[each.value.vnet_key].address_space
  virtual_hub_as_data = try(local.settings.networking.virtual_wans[each.value.vwan_key].virtual_hubs[each.value.vhub_key].reuse, false)
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_azurerm.vhub_provider"></a> [azurerm.vhub\_provider](#provider\_azurerm.vhub\_provider) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_hub_connection.vhubconn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection) | resource |
| [azurerm_virtual_hub_connection.vhubconn_data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_vhub_connection"></a> [vhub\_connection](#input\_vhub\_connection) | Configuration settings object for the Virtual Hub Connection resource | `any` | n/a | yes |
| <a name="input_virtual_hub"></a> [virtual\_hub](#input\_virtual\_hub) | Virtual Hub module object | `any` | n/a | yes |
| <a name="input_virtual_hub_as_data"></a> [virtual\_hub\_as\_data](#input\_virtual\_hub\_as\_data) | Flag used to determine if vhub\_subscription provider is used to build the resource | `bool` | `false` | no |
| <a name="input_virtual_hub_id"></a> [virtual\_hub\_id](#input\_virtual\_hub\_id) | The ID of the Virtual Hub within which this connection should be created (**Set when not using data resource) | `string` | `null` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the Virtual Network which the Virtual Hub should be connected to | `string` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The Address Space of the Virtual Network - used for the naming object | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Hub Connection |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Hub Connection |
<!-- END_TF_DOCS -->