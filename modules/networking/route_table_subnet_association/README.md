# Subnet / Route Table Association

Module will create/manage the following resources:
* Associate a Route Table to a Virtual Networks Subnet

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
        subnet2:
          name: ADDS
          enabled: true
          address_prefixes: ["172.31.205.0/24"]
          # Apply Route Table to Subnet
          route_table_key: "AzFirewall"        
```

## Example Module Reference

```yaml
module "rt_subnet_assoc" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/route_table_subnet_association"
  for_each = {
    for key, value in try(local.settings.networking.vnets, {}) : key => value
    if try(value.enabled, false) == true
  }

  route_tables             = module.route_tables
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
| [azurerm_subnet_route_table_association.rt_vnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | Route Tables module object | `any` | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | VNets module object containing Subnet IDs | `any` | n/a | yes |
| <a name="input_virtual_network_settings"></a> [virtual\_network\_settings](#input\_virtual\_network\_settings) | Singular VNet settings object | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Route Table/Subnet Association |
<!-- END_TF_DOCS -->