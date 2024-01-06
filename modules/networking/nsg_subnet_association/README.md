# Subnet / Network Security Group Association

Module will create/manage the following resources:
* Associate a Network Security Group to a Virtual Networks Subnet

## Example Settings
```yaml
networking:
  network_security_groups:
    # Empty NSG requires name, resource_group_key and enabled boolean
    mgmt_nsg:
      name: "MGMT_SUBNET"
      resource_group_key: "networking"
      enabled: true

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
```

## Example Module Reference

```yaml
module "nsg_subnet_assoc" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/nsg_subnet_association"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true
  }

  network_security_groups  = module.network_security_groups
  virtual_network_settings = each.value
  virtual_network          = module.networking[each.key]
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
| [azurerm_subnet_network_security_group_association.nsg_vnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_security_groups"></a> [network\_security\_groups](#input\_network\_security\_groups) | NSG module object | `any` | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | VNets module object containing Subnet IDs | `any` | n/a | yes |
| <a name="input_virtual_network_settings"></a> [virtual\_network\_settings](#input\_virtual\_network\_settings) | Singular VNet settings object | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the NSG/Subnet Association |
<!-- END_TF_DOCS -->