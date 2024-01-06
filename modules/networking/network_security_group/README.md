# Network Security Group

Module will create/manage the following resources:
* Network Security Group (with Rules and optional NSG Log Flows)

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{name}{delimiter}{nsg}"

Example Result: AVA-EUS2-DEV-APP-NSG
```

## Example Settings
```yaml
networking:
  network_security_groups:
    # Empty NSG requires name, resource_group_key and enabled boolean
    mgmt_nsg:
      name: "MGMT_SUBNET"
      resource_group_key: "networking"
      enabled: true
      flow_logs:
        fl1:
          enabled: true
          storage_account:
            storage_account_key: "st1"
            retention:
              enabled: true
              days: 30
    web_nsg:
      name: "WEB_SUBNET"
      resource_group_key: "networking"
      enabled: true
      flow_logs:
        fl1:
          enabled: true
          storage_account:
            storage_account_key: "st1"
            retention:
              enabled: true
              days: 30
      rules:
        rule1:
          name: "web-inbound-http"
          priority: "103"
          direction: "Inbound"
          access: "Allow"
          protocol: "Tcp"
          source_port_range: "*"
          destination_port_range: "80"
          source_address_prefix: "*"
          destination_address_prefix: "VirtualNetwork"
        rule2:
          name: "web-inbound-https"
          priority: "104"
          direction: "Inbound"
          access: "Allow"
          protocol: "Tcp"
          source_port_range: "*"
          destination_port_range: "443"
          source_address_prefix: "*"
          destination_address_prefix: "VirtualNetwork"
        rule3:
          name: "web-from-jump-host"
          priority: "120"
          direction: "Inbound"
          access: "Allow"
          protocol: "Tcp"
          source_port_range: "*"
          destination_port_range: "22"
          source_address_prefix: "10.1.1.0/24"
          destination_address_prefix: "VirtualNetwork"
        rule4:
          name: "ACP-DENY-ALL-OUTBOUND"
          priority: "4096"
          direction: "Outbound"
          access: "Deny"
          protocol: "*"
          source_port_range: "*"
          destination_port_range: "*"
          source_address_prefix: "*"
          destination_address_prefix: "*"
        rule5:
          name: "ACP-DENY-ALL-INBOUND"
          priority: "4096"
          direction: "Inbound"
          access: "Deny"
          protocol: "*"
          source_port_range: "*"
          destination_port_range: "*"
          source_address_prefix: "*"
          destination_address_prefix: "*"

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
          # Apply Route Table to Subnet
          route_table_key: "bypassAzFirewall"
        subnet3:
          name: WEB
          enabled: true
          address_prefixes: ["172.31.206.0/24"]
          # Apply NSG to Subnet
          nsg_key: "web_nsg"
        subnet4:
          name: AzureBastionSubnet
          enabled: true
          address_prefixes: ["172.31.206.0/26"]
```

## Example Module Reference

```yaml
module "network_security_groups" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/network_security_group"
  for_each = {
    for key, value in try(local.settings.networking.network_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == false
  }

  global_settings                   = local.settings
  resource_group_name               = local.resource_groups[each.value.resource_group_key].name
  network_security_group            = each.value
  application_security_groups       = module.app_security_groups
  network_watchers                  = module.network_watchers
  diagnostics                       = local.diagnostics
  tags                              = try(each.value.tags, null)
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
| <a name="module_nsg_flows"></a> [nsg\_flows](#module\_nsg\_flows) | ./flow_logs | n/a |
| <a name="module_resource_naming"></a> [resource\_naming](#module\_resource\_naming) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg_obj](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_security_groups"></a> [application\_security\_groups](#input\_application\_security\_groups) | Application Security Groups module object | `map` | `{}` | no |
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostics object for the NSG Flow Logs resource | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_network_security_group"></a> [network\_security\_group](#input\_network\_security\_group) | Configuration settings object for the NSG definition resource | `any` | n/a | yes |
| <a name="input_network_watchers"></a> [network\_watchers](#input\_network\_watchers) | Network Watchers module object used by NSG Flow Logs | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the NSG |
| <a name="output_name"></a> [name](#output\_name) | The Name of the NSG |
<!-- END_TF_DOCS -->