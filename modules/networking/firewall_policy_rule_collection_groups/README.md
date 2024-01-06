# Azure Firewall Policy Rule Collection Group

## Default Naming Convention
```
rcg_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicyrcg}"
netrule_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicynetrule}"
apprule_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicyapprule}"
natrule_name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewallpolicynatrule}"

Example Result: 
RCG: AVA-EUS2-DEV-AZFW-POLICY-RCG
NETRULE: AVA-EUS2-DEV-NETWORK-RC
APPRULE: AVA-EUS2-DEV-APPLICATION-RC
NATRULE: AVA-EUS2-DEV-DNAT-RC
```

## Example Settings
```yaml
networking:  
  firewall_policy_rulecollectiongroups:
    rcg1:
      enabled: true
      firewall_policy_key: "fp1"
      priority: 100
      network_rule_collections:
        nrc1:
          priority: 100
          action: "Allow"
          rules:
            ncrule1:
              name: "Allow-Vnet1-to-Vnet2"
              source_addresses: ["10.50.144.0/22",]
              destination_addresses: ["10.50.156.0/22"]
              destination_ports: ["*"]
              protocols: ["Any"]
            ncrule2:
              name: "Allow-Vnet2-to-Vnet1"
              source_addresses: ["10.50.156.0/22"]
              destination_addresses: ["10.50.144.0/22",]
              destination_ports: ["443"]
              protocols: ["TCP"]
      application_rule_collections:
        arc1:
          priority: 300
          action: "Allow"
          rules:
            ncrule1:
              name: "Allow-SVRTest-Outbound-WebTraffic"
              source_addresses: ["10.50.144.0/22","10.50.156.0/22",]
              destination_fqdns: ["*"]
              protocols:
                p1:
                  type: "Http"
                  port: 80
                p2:
                  type: "Https"
                  port: 443
      # nat_rule_collections:
```

## Example Module Reference

```yaml
module "firewall_policy_rcgs" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/firewall_policy_rule_collection_groups"
  for_each = {
    for key, value in try(local.settings.networking.firewall_policy_rulecollectiongroups, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings    = local.settings
  policy_settings    = each.value
  firewall_policy_id = module.firewall_policy[each.value.firewall_policy_key].id
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
| <a name="module_resource_naming_apprule"></a> [resource\_naming\_apprule](#module\_resource\_naming\_apprule) | ../../resource_naming | n/a |
| <a name="module_resource_naming_natrule"></a> [resource\_naming\_natrule](#module\_resource\_naming\_natrule) | ../../resource_naming | n/a |
| <a name="module_resource_naming_netrule"></a> [resource\_naming\_netrule](#module\_resource\_naming\_netrule) | ../../resource_naming | n/a |
| <a name="module_resource_naming_rcg"></a> [resource\_naming\_rcg](#module\_resource\_naming\_rcg) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy_rule_collection_group.polgroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | The ID of the Firewall Policy where the Firewall Policy Rule Collection Group should exist | `string` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_ip_groups"></a> [ip\_groups](#input\_ip\_groups) | IP groups module object | `map` | `{}` | no |
| <a name="input_policy_settings"></a> [policy\_settings](#input\_policy\_settings) | Configuration settings object for the Azure Firewall Policy resource | `any` | n/a | yes |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Public IP addresses module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Firewall Policy Rule Collection Group |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Firewall Policy Rule Collection Group |
<!-- END_TF_DOCS -->