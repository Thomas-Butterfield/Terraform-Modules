# Virtual Network Gateway

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vng}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-VNG-001
```

## Example Settings
```yaml
networking:
  virtual_network_gateways:
    vng1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      sku:
      type: "Vpn"
      enable_bgp: true
      generation: "Generation2"
      ip_configuration:
        ipc1:
          name: "vnetGatewayConfig"
          public_ip_address_key: "pipvpn1"
          vnet_key: "vnet1"
          subnet_key: "subnet1"


```

## Example Module Reference

```yaml
module "virtual_network_gateways" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network_gateway"
  for_each = {
    for key, value in try(local.settings.networking.virtual_network_gateways, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings     = local.settings
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  settings            = each.value
  virtual_networks    = module.networking
  public_ip_addresses = module.public_ip_address
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
| [azurerm_virtual_network_gateway.vngw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. If ommitted, default value is var.global\_settings.location. | `string` | `null` | no |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Public IP Addresses module object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Virtual Network Gateway resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Network Gateway |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Network Gateway |
<!-- END_TF_DOCS -->