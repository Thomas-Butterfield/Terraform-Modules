# Virtual HUB Data Resource

## Example Settings
```yaml
networking:
  virtual_wans:
    vwan1data: #data vwan
      enabled: true
      name: "CONNECT-EUS2-DEV-VWAN"
      rg_name: "CONNECT-EUS2-DEV-NETWORK-RG"
      reuse: true
      virtual_hubs:
        vhub1data:
          name: "CONNECT-EUS2-DEV-VHUB-01"
          rg_name: "CONNECT-EUS2-DEV-NETWORK-RG"
          reuse: true
```

## Example Module Reference

```yaml
module "virtual_wans_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_wan_reused"
  providers = {
    azurerm               = azurerm
    azurerm.vhub_provider = azurerm.hub_subscription
  }
  for_each = {
    for key, value in try(local.settings.networking.virtual_wans, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }

  global_settings     = local.settings
  resource_group_name = try(each.value.rg_name, null) != null ? each.value.rg_name : try(each.value.resource_group_key, null) != null ? local.resource_groups[each.value.resource_group_key].name : null
  virtual_wan         = each.value
  virtual_networks    = try(module.networking, {})
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.vhub_provider"></a> [azurerm.vhub\_provider](#provider\_azurerm.vhub\_provider) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_hub.vwan_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_hub) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Public IP Addresses module object | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_hub"></a> [virtual\_hub](#input\_virtual\_hub) | Configuration settings object for the Virtual Hub resource | `any` | n/a | yes |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `any` | n/a | yes |
| <a name="input_vwan_id"></a> [vwan\_id](#input\_vwan\_id) | Resource ID for the Virtual WAN object | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Virtual Hub |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Data Virtual Hub |
<!-- END_TF_DOCS -->