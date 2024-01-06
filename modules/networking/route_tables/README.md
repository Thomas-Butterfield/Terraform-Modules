# Route Table (with routes)

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{routetable}{delimiter}{name}"

Example Result: AVA-EUS2-DEV-RT-BypassAzFw
```

## Example Settings
```yaml
networking:
  route_tables:
    AzFirewall:
      name: "RouteTable-Firewall"
      resource_group_key: "networking"
      enabled: true
      firewall_key: "azfw1"
      routes:
        rt1:
          name: "Internet"
          address_prefix: "0.0.0.0/0"
          next_hop_type: "VirtualAppliance"
          # next_hop_in_ip_address: "10.10.0.4"
          # Pass in firewall_ip_address variable if not explicitly using next_hop_in_ip_address
        rt2:
          name: "Route-To-Internal"
          address_prefix: "10.0.0.0/8"
          next_hop_type: "VirtualAppliance"
        ## Use below if we want VMs within subnet to use Firewall
        # rt3:
        #   name: "Route-To-Firewall"
        #   address_prefix: "10.10.1.0/24" # Use exact subnet CIDR to override system routes
        #   next_hop_type: "VirtualAppliance"
```

## Example Module Reference

```yaml

module "route_tables" {
  source     = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/route_tables"
  for_each = {
    for key, value in try(local.settings.networking.route_tables, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings     = local.settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
  firewall_ip_address = try(module.firewall[each.value.firewall_key].ip_configuration[0].private_ip_address, null)
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
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_ip_address"></a> [firewall\_ip\_address](#input\_firewall\_ip\_address) | Firewall private IP address to be used if next\_hop\_in\_ip\_address = VirtualAppliance | `string` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Route Table resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route Table |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Route Table |
<!-- END_TF_DOCS -->