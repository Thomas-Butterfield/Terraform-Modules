# Virtual HUB

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vhub}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-VHUB-01
```

## Example Settings
```yaml
networking:
  virtual_wans:
    vwan1:
      enabled: true
      resource_group_key: "networking"
      virtual_hubs:
        vhub1:
          hub_address_prefix: "172.16.0.0/16"
          naming_convention: #(Required)
            postfix: "01"
          deploy_s2s: false
          s2s_config:
            scale_unit: 1
```

## Example Module Reference

```yaml
module "virtual_wans" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_wan"
  for_each = {
    for key, value in try(local.settings.networking.virtual_wans, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings     = local.settings
  resource_group_name = try(each.value.rg_name, null) != null ? each.value.rg_name : try(each.value.resource_group_key, null) != null ? local.resource_groups[each.value.resource_group_key].name : null
  virtual_wan         = each.value
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
| <a name="module_resource_naming_bgp"></a> [resource\_naming\_bgp](#module\_resource\_naming\_bgp) | ../../../resource_naming | n/a |
| <a name="module_resource_naming_erg"></a> [resource\_naming\_erg](#module\_resource\_naming\_erg) | ../../../resource_naming | n/a |
| <a name="module_resource_naming_hub_ip"></a> [resource\_naming\_hub\_ip](#module\_resource\_naming\_hub\_ip) | ../../../resource_naming | n/a |
| <a name="module_resource_naming_p2s"></a> [resource\_naming\_p2s](#module\_resource\_naming\_p2s) | ../../../resource_naming | n/a |
| <a name="module_resource_naming_s2s"></a> [resource\_naming\_s2s](#module\_resource\_naming\_s2s) | ../../../resource_naming | n/a |
| <a name="module_resource_naming_spp"></a> [resource\_naming\_spp](#module\_resource\_naming\_spp) | ../../../resource_naming | n/a |
| <a name="module_resource_naming_vhub"></a> [resource\_naming\_vhub](#module\_resource\_naming\_vhub) | ../../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_express_route_gateway.er_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/express_route_gateway) | resource |
| [azurerm_point_to_site_vpn_gateway.p2s_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/point_to_site_vpn_gateway) | resource |
| [azurerm_virtual_hub.vwan_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub) | resource |
| [azurerm_vpn_gateway.s2s_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway) | resource |
| [azurerm_vpn_server_configuration.p2s_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_server_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Public IP Addresses module object | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_hub"></a> [virtual\_hub](#input\_virtual\_hub) | Configuration settings object for the Virtual Hub resource | `any` | n/a | yes |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `any` | n/a | yes |
| <a name="input_vwan_id"></a> [vwan\_id](#input\_vwan\_id) | Resource ID for the Virtual WAN object | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_route_table_id"></a> [default\_route\_table\_id](#output\_default\_route\_table\_id) | The Default Route Table Resource ID of the Virtual Hub |
| <a name="output_er_gateway"></a> [er\_gateway](#output\_er\_gateway) | The Virtual Network Gateway - Express Route resource object |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Data Virtual Hub |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Hub |
| <a name="output_p2s_gateway"></a> [p2s\_gateway](#output\_p2s\_gateway) | The Virtual Network Gateway - Point to Site resource object |
| <a name="output_s2s_gateway"></a> [s2s\_gateway](#output\_s2s\_gateway) | The Virtual Network Gateway - Site 2 Site resource object |
| <a name="output_virtual_hub"></a> [virtual\_hub](#output\_virtual\_hub) | The Virtual Hub resource object |
<!-- END_TF_DOCS -->