# Azure Firewall

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{azfirewall}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-AZFW-01
```

## Example Settings
```yaml
networking:  
  azfirewalls:
    #virtual hub secured firewall
    azfw1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "01"
      sku_name: "AZFW_Hub" #needed if attaching to VHub
      sku_tier: "Standard"
      firewall_policy_key: "fp1"
      vhub_key: "vhub1" #used for looking up object below
      vwan_key: "vwan1"
      public_ip_count: 1
```

## Example Module Reference

```yaml
module "hub_firewall" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/firewall"
  for_each = {
    for key, value in try(local.settings.networking.azfirewalls, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  firewall            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  virtual_hubs        = module.virtual_wans[each.value.vwan_key].virtual_hubs
  firewall_policy_id  = module.firewall_policy[each.value.firewall_policy_key].id
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
| [azurerm_firewall.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Configuration settings object for the Firewall resource | `any` | n/a | yes |
| <a name="input_firewall_policy_id"></a> [firewall\_policy\_id](#input\_firewall\_policy\_id) | The ID of the Firewall Policy applied to this Firewall | `string` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | Public IP addresses module object (**Only required if not attaching to Virtual Hub) | `map` | `{}` | no |
| <a name="input_public_ip_id"></a> [public\_ip\_id](#input\_public\_ip\_id) | Public IP address identifier. IP address must be of type static and standard | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (VHUB=Optional/HubSpoke=Required) Reference to a subnet in which this Firewall will be created (**Must be created in advance) | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs) | Virtual Hub module object (**Only required if attaching to Virtual Hub) | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object (**Only required if not attaching to Virtual Hub) | `map` | `{}` | no |
| <a name="input_virtual_wans"></a> [virtual\_wans](#input\_virtual\_wans) | Virtual WAN module object (**Only required if attaching to Virtual Hub and if not providing var.virtual\_hubs) | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Azure Firewall |
| <a name="output_ip_configuration"></a> [ip\_configuration](#output\_ip\_configuration) | The IP Configuration (Private IP Address) of the Azure Firewall |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Azure Firewall |
| <a name="output_virtual_hub"></a> [virtual\_hub](#output\_virtual\_hub) | The Virtual Hub resource object if Secured Hub |
<!-- END_TF_DOCS -->