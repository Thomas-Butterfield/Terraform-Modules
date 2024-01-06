# Virtual Network

Module will create/manage the following resources:
* Virtual Network
* Subnet
* Subnet - NSG Association
* Subnet - Route Table Association

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vnet}-{postfix}_{vnet_address_space}"

Example Result: SHAREDSVC-EUS2-DEV-VNET-01_172.31.204.0_22
```

## Example Settings
```yaml
networking:  
  vnets:
    vnet1:
      naming_convention:
        postfix: "01"
      enabled: true
      resource_group_key: "networking"
      address_space: ["172.31.204.0/22"]
      subnets:
        subnet1:                 
          name: MGMT
          enabled: true
          address_prefixes: ["172.31.204.0/24"]
          # Apply NSG to Subnet
          nsg_key: "mgmt_nsg"
        subnet2:
          name: ADDS
          enabled: true
          address_prefixes: ["172.31.205.0/24"]
          # Apply NSG to Subnet
          nsg_key: "adds_nsg"
          # Apply Route Table to Subnet
          route_table_key: "bypassAzFirewall"
        subnet3:
          name: AzureBastionSubnet
          enabled: true
          address_prefixes: ["172.31.206.0/26"]
```

## Example Module Reference

```yaml
module "networking" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings                   = local.settings
  resource_group_name               = local.resource_groups[each.value.resource_group_key].name
  virtual_network                   = each.value
  tags                              = try(each.value.tags, null)
  # diagnostics                       = local.diagnostics
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
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ./subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostics object for the NSG Flow Logs resource | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | Configuration settings object for the Virtual Network resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The Address Space of the Virtual Network |
| <a name="output_dns_servers"></a> [dns\_servers](#output\_dns\_servers) | The DNS Servers of the Virtual Network |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Network |
| <a name="output_location"></a> [location](#output\_location) | The Location of the Virtual Network |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Network |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The Resource Group Name of the Virtual Network |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The Subnets module object in the Virtual Network |
<!-- END_TF_DOCS -->