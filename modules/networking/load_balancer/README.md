# Load Balancer

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lb}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-LB-01
```

## Example Settings
```yaml
load_balancers:
  ## private LB example
  trustedlb:
    naming_convention:
      postfix: "Private-01"
    enabled: true
    resource_group_key: "networking"
    sku: "Standard"
    sku_tier: "Regional"
    type: "private"
    frontend:
      fe1:
        name: "frontendIpName"
        vnet_key: "vnet1"
        subnet_key: "subnet1"
    probes:
      probe1:
        naming_convention:
          postfix: "01"
        enabled: false
        protocol: "Https"
        # required if above is set to "Http" or "Https"
        request_path: "/"
        port: 443
      probe2:
        naming_convention:
          postfix: "01"
        enabled: true
        protocol: "Tcp"
        port: 22
      probe3:
        naming_convention:
          postfix: "01"
        enabled: false
        protocol: "Http"
        request_path: "/"
        port: 80
    rules:
      rule1:
        naming_convention:
          postfix: "01"
        enabled: true
        protocol: "All"
        frontend_key: "fe1"
        probe_key: probe2
        enable_floating_ip: true
      rule2:
        naming_convention:
          postfix: "02"
        enabled: false
        protocol: "Tcp"
        frontend_port: 22
        backend_port: 22
        frontend_key: "fe1"
        probe_key: probe2
        enable_floating_ip: true
    backend_pool_assoc:
      assoc1:
        resource_key: "pa-vm1"
        nic_id_key: "trust-nic"
        enabled: true
      assoc2:
        resource_key: "pa-vm2"
        nic_id_key: "trust-nic"
        enabled: true

  ## public LB example
  untrustedlb:
    naming_convention:
      postfix: "Public-01"
    enabled: true
    resource_group_key: "networking"
    sku: "Standard"
    sku_tier: "Regional"
    type: "public"
    frontend:
      fe1:
        name: "frontendIpName"
        pip_key: "piplb1"
      fe2:
        name: "frontendIpName2"
        pip_key: "piplb2"
    probes:
      probe1:
        naming_convention:
          postfix: "01"
        enabled: true
        port: "443"
        protocol: "Https"
        request_path: "/"
      probe2:
        naming_convention:
          postfix: "02"
        enabled: true
        port: "22"
        protocol: "Tcp"
      probe3:
        naming_convention:
          postfix: "03"
        enabled: true
        port: "80"
        protocol: "Http"
        request_path: "/testpage/index.htm"
    rules:
      rule1:
        naming_convention:
          postfix: "01"
        enabled: true
        protocol: "Tcp"
        frontend_port: 443
        backend_port: 443
        # index number of above frontend IP list, starting with 0
        frontend_key: "fe1"
        probe_key: probe2
        enable_floating_ip: true
      rule2:
        naming_convention:
          postfix: "02"
        enabled: true
        protocol: "Tcp"
        frontend_port: 22
        backend_port: 22
        frontend_key: "fe1"
        probe_key: probe2
        enable_floating_ip: true
      rule3:
        naming_convention:
          postfix: "03"
        enabled: true
        protocol: "Tcp"
        frontend_port: 22
        backend_port: 22
        frontend_key: "fe2"
        probe_key: probe2
        enable_floating_ip: true
      rule4:
        naming_convention:
          postfix: "04"
        enabled: true
        protocol: "Udp"
        frontend_port: 53
        backend_port: 53
        frontend_key: "fe1"
        probe_key: probe2
    backend_pool_assoc:
      assoc1:
        resource_key: "pa-vm1"
        nic_id_key: "untrust-nic"
        enabled: true
      assoc2:
        resource_key: "pa-vm2"
        nic_id_key: "untrust-nic"
        enabled: true

```

## Example Module Reference

```yaml
module "lb" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/load_balancer

  for_each = {
    for key, value in try(local.settings.load_balancers, {}) : key => value
    if try(value.reuse, false) == false && try(value.enabled, false) == true
  }

  global_settings       = local.settings
  location              = local.settings.location
  tags                  = try(each.value.tags, null)
  resource_group_name   = try(each.value.rg_name, null) != null ? each.value.rg_name : try(each.value.resource_group_key, null) != null ? local.resource_groups[each.value.resource_group_key].name : null
  settings              = each.value
  type                  = try(each.value.type, null)
  backend_resources     = module.virtual_machines
  public_ips            = module.public_ip_address
  subnet_id             = module.networking
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
| <a name="module_lb_backend_pool_assoc"></a> [lb\_backend\_pool\_assoc](#module\_lb\_backend\_pool\_assoc) | ./lb_backend_pool_assoc | n/a |
| <a name="module_lb_nat_rule"></a> [lb\_nat\_rule](#module\_lb\_nat\_rule) | ./lb_nat_rule | n/a |
| <a name="module_lb_probe"></a> [lb\_probe](#module\_lb\_probe) | ./lb_probe | n/a |
| <a name="module_load_balancer_rule"></a> [load\_balancer\_rule](#module\_load\_balancer\_rule) | ./lb_rule | n/a |
| <a name="module_resource_naming_lb"></a> [resource\_naming\_lb](#module\_resource\_naming\_lb) | ../../resource_naming | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.bap](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_resources"></a> [backend\_resources](#input\_backend\_resources) | Backend Resources module object containing NIC resource ID | `map` | `{}` | no |
| <a name="input_gateway_fe_ip_id"></a> [gateway\_fe\_ip\_id](#input\_gateway\_fe\_ip\_id) | n/a | `string` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Ommitting this variable will default to the var.global\_settings.location value. | `string` | `null` | no |
| <a name="input_public_ips"></a> [public\_ips](#input\_public\_ips) | Public IP Addresses module object | `map` | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Load Balancer resource | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet which should be associated with the IP Configuration | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual Networks module object | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_network_interface_backend_address_pool_association_id"></a> [azurerm\_network\_interface\_backend\_address\_pool\_association\_id](#output\_azurerm\_network\_interface\_backend\_address\_pool\_association\_id) | The Load Balancer Backend Address Pool Association ID |
| <a name="output_id"></a> [id](#output\_id) | The Load Balancer ID |
| <a name="output_lb_backend_addr_pool_id"></a> [lb\_backend\_addr\_pool\_id](#output\_lb\_backend\_addr\_pool\_id) | The Load Balancer Backend Address Pool ID |
| <a name="output_lb_backend_addr_pool_ip_config"></a> [lb\_backend\_addr\_pool\_ip\_config](#output\_lb\_backend\_addr\_pool\_ip\_config) | The Load Balancer Backend IP Configuration object |
| <a name="output_lb_backend_addr_pool_nat_rules"></a> [lb\_backend\_addr\_pool\_nat\_rules](#output\_lb\_backend\_addr\_pool\_nat\_rules) | The Load Balancer Backend Address Pool NAT Rules |
| <a name="output_lb_backend_addr_pool_out_rules"></a> [lb\_backend\_addr\_pool\_out\_rules](#output\_lb\_backend\_addr\_pool\_out\_rules) | The Load Balancer Backend Address Pool Outbound Rules |
| <a name="output_lb_backend_addr_pool_rules"></a> [lb\_backend\_addr\_pool\_rules](#output\_lb\_backend\_addr\_pool\_rules) | The Load Balancer Backend Address Pool Rules |
| <a name="output_lb_frontend_ip_configuration"></a> [lb\_frontend\_ip\_configuration](#output\_lb\_frontend\_ip\_configuration) | The Load Balancer Frontend IP Configuration object |
| <a name="output_lb_private_ip_address"></a> [lb\_private\_ip\_address](#output\_lb\_private\_ip\_address) | The Load Balancer Frontend IP Configuration Private IP Address |
| <a name="output_lb_probe"></a> [lb\_probe](#output\_lb\_probe) | The Load Balancer Probe object |
| <a name="output_lb_rules"></a> [lb\_rules](#output\_lb\_rules) | The Load Balancer Rules |
| <a name="output_name"></a> [name](#output\_name) | The Load Balancer Name |
<!-- END_TF_DOCS -->