# Virtual Network Peering

## Default Naming Convention
```
name_mask = "{referenced_name}{delimiter}to{delimiter}{referenced_name_1}"

**Local variable attempts to strip VNet Address Prefix from VNet Names
Example Result: SHAREDSVC-EUS2-DEV-VNET-01-to-SPOKE1-EUS2-DEV-VNET-01
```

## Example Settings
```yaml
# Settings below are example for Virtual Network to Remote Shared Service Hub VNet
networking:
  vnet1:
    enabled: true
    naming_convention:
      postfix: "001"
    enabled: true
    resource_group_key: "networking"
    address_space: ["10.0.144.0/22"]
    subnets:
      subnet1:                 
        name: MGMT
        enabled: true
        address_prefixes: ["10.0.144.32/27"]
  vnet_hub:      
    enabled: true
    reuse: true
    use_sharedsvc_provider: true
    name: "AVA-CUS-CONNECT-TST-VNET-001"
    rg_name: "AVA-CUS-CONNECT-TST-NETWORK-RG"

  virtual_network_peerings:
    vnet1-to-hub:
      enabled: true
      vnet_key: "vnet1"
      remote_vnet_key: "vnet_hub"
      resource_group_key: "networking"
      use_remote_gateways: true

# Alternate settings below are example for Shared Service Hub VNet to Remote Virtual Network
networking:
  virtual_network_peerings:
    hub-to-vnet1:
      enabled: true
      use_sharedsvc_provider: true
      vnet_key: "vnet_hub"
      remote_vnet_key: "vnet1"
      resource_group_key: "networking"
      allow_virtual_network_access: true
      allow_gateway_transit: true
      allow_forwarded_traffic: true
      use_remote_gateways: true
```

## Example Module Reference

```yaml
## Virtual network peering
module "virtual_network_peerings" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network_peering"
  for_each = {
    for key, value in try(local.settings.networking.virtual_network_peering, {}) : key => value
    if try(value.enabled, false) == true && try(value.use_sharedsvc_provider, false) == false
  }

  global_settings             = local.settings
  resource_group_name         = local.resource_groups[each.value.resource_group_key].name
  vnet_peering                = each.value
  virtual_network_name        = module.networking[each.value.vnet_key].name
  remote_virtual_network_id   = module.networking_reused[each.value.remote_vnet_key].id
  remote_virtual_network_name = module.networking_reused[each.value.remote_vnet_key].name
}

module "virtual_network_peerings_hub" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network_peering"
  providers = {
    azurerm = azurerm.sharedsvc_subscription
  }

  for_each = {
    for key, value in try(local.settings.networking.virtual_network_peering, {}) : key => value
    if try(value.enabled, false) == true && try(value.use_sharedsvc_provider, false) == true
  }

  global_settings             = local.settings
  resource_group_name         = local.resource_groups[each.value.resource_group_key].name
  vnet_peering                = each.value
  virtual_network_name        = module.networking_reused[each.value.vnet_key].name
  remote_virtual_network_id   = module.networking[each.value.remote_vnet_key].id
  remote_virtual_network_name = module.networking[each.value.remote_vnet_key].name
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
| [azurerm_virtual_network_peering.vnet-peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_remote_virtual_network_id"></a> [remote\_virtual\_network\_id](#input\_remote\_virtual\_network\_id) | The ID of the Remote Virtual Network which the Virtual Network will be peered with | `string` | n/a | yes |
| <a name="input_remote_virtual_network_name"></a> [remote\_virtual\_network\_name](#input\_remote\_virtual\_network\_name) | The Name of the Remote Virtual Network to be used for naming the peering resource | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The Name of the Virtual Network that will be peered with the remote VNet | `string` | n/a | yes |
| <a name="input_vnet_peering"></a> [vnet\_peering](#input\_vnet\_peering) | Configuration settings object for the Virtual Network Peering resource | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Network Peering |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Network Peering |
<!-- END_TF_DOCS -->