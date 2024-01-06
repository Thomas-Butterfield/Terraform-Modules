# Virtual Network Data Resource

Module will retrieve data resources for the following resources:
* Virtual Network
* Subnet

## Example Settings
```yaml
networking:
  vnets:
    vnet1:
      enabled: true
      reuse: true
      name: "SHAREDSVC-EUS2-DEV-VNET-01_172.31.204.0_22"
      rg_name: "SHAREDSVC-EUS2-DEV-NETWORK-RG"
      subnets:
        subnet1:                 
          name: "SHAREDSVC-EUS2-DEV-MGMT-SNET_172.31.204.0_24"
          enabled: true
          reuse: true  
```

## Example Module Reference

```yaml
module "networking" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings                   = local.settings
  network_security_group_definition = try(local.settings.networking.network_security_group_definition, {})
  resource_group_name               = local.resource_groups[each.value.resource_group_key].name
  virtual_network                   = each.value
  route_tables                      = module.route_tables
  tags                              = try(each.value.tags, null)
}

module "networking_reused" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network_reused"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }

  global_settings     = local.settings
  virtual_network     = each.value
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
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ./subnet | n/a |
| <a name="module_subnets_reused"></a> [subnets\_reused](#module\_subnets\_reused) | ./subnet_reused | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
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
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The Subnets module object in the Virtual Network. Contains merged data and managed subnet objects. |
| <a name="output_subnets_all"></a> [subnets\_all](#output\_subnets\_all) | The list of name of the subnets that are attached to this virtual network |
<!-- END_TF_DOCS -->