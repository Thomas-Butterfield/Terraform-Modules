# Network Security Group Data Resource

## Example Settings
```yaml
networking:
  network_security_groups:
    # MGMT NSG is already provisioned outside of this code! See below 
    mgmt_nsg:
      enabled: true
      reuse: true
      name: "TEST-DATA-NSG"
      rg_name: "AVA-DEMO-CUS-CORP-PROD-NETWORK-RG"
      # You can enable a flow log on an existing (data) NSG resource
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

```

## Example Module Reference

```yaml
module "network_security_groups_reused" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/network_security_group_reused"
  for_each = {
    for key, value in try(local.settings.networking.network_security_groups, {}) : key => value
    if try(value.enabled, false) == true && try(value.reuse, false) == true
  }

  global_settings                   = local.settings
  network_security_group            = each.value
  network_watchers                  = module.network_watchers
  diagnostics                       = local.diagnostics
}

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

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg_obj](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diagnostics"></a> [diagnostics](#input\_diagnostics) | Diagnostics object for the NSG Flow Logs resource | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_network_security_group"></a> [network\_security\_group](#input\_network\_security\_group) | Configuration settings object for the NSG definition resource | `any` | n/a | yes |
| <a name="input_network_watchers"></a> [network\_watchers](#input\_network\_watchers) | Network Watchers module object used by NSG Flow Logs | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created. Default to network\_security\_group.rg\_name | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the NSG |
| <a name="output_name"></a> [name](#output\_name) | The Name of the NSG |
<!-- END_TF_DOCS -->