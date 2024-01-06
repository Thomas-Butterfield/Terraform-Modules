# Virtual HUB Route Table

If a virtual_hub_route_tables key is provided == "default_route_table", the code will attempt to create a route in the default route table with the provided settings.

Otherwise, new route tables will be created and attached to the VHUB as provided in the settings configuration.

## Example Settings
```yaml
networking:
  virtual_hub_route_tables:
    default_route_table:
      enabled: true
      vhub_key: "vhub1"
      vwan_key: "vwan1"
      firewall_key: "azfw1"
      route_name: "SecureAllTraffic"
      address_prefixes: ["0.0.0.0/0,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"]
      next_hop: firewall
    zero_trust_rt_table:
      enabled: true
      vhub_key: "vhub1"
      vwan_key: "vwan1"
      firewall_key: "azfw1"
      rt_table_name: "ZeroTrust"
      label: "ZeroTrust"
      routes:
        route:
          route_name: "ZeroTrust"
          address_prefixes: ["0.0.0.0/0"]
          next_hop: firewall
```

## Example Module Reference

```yaml
module "hub_route_table" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_wan/virtual_hub/route_table"
  for_each = {
    for key, value in try(local.settings.networking.virtual_hub_route_tables, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings      = local.settings
  settings             = each.value
  rt_table_key         = each.key
  vhub                 = module.virtual_wans[each.value.vwan_key].virtual_hubs[each.value.vhub_key]
  firewall_resource_id = module.hub_firewall[each.value.firewall_key].id
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
| [azurerm_virtual_hub_route_table.vhub-routetable](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_route_table) | resource |
| [azurerm_virtual_hub_route_table_route.vhub-defaultroutetablert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub_route_table_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_resource_id"></a> [firewall\_resource\_id](#input\_firewall\_resource\_id) | Resource ID for the Virtual Hub Azure Firewall | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_rt_table_key"></a> [rt\_table\_key](#input\_rt\_table\_key) | Route Table Key Name from configuration settings | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Virtual Hub Route Table resource | `any` | n/a | yes |
| <a name="input_vhub"></a> [vhub](#input\_vhub) | Virtual Hub module object | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Hub Route Table |
<!-- END_TF_DOCS -->