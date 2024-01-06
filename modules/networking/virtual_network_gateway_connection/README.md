# Virtual Network Gateway Connection

## Default Naming Convention
```
name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{vngc}{delimiter}{postfix}"

Example Result: AVA-EUS2-DEV-VNGConn-001
```

## Example Settings
```yaml
networking:
  virtual_network_gateways:
    vng1:
      enabled: true
      resource_group_key: "networking"
      naming_convention:
        postfix: "001"
      sku:
      type: "Vpn"
      enable_bgp: true
      generation: "Generation2"
      ip_configuration:
        ipc1:
          name: "vnetGatewayConfig"
          public_ip_address_key: "pipvpn1"
          vnet_key: "vnet1"
          subnet_key: "subnet1"

  virtual_network_gateway_connections:
    # ExpressRoute
    vngconn1:
      enabled: false
      resource_group_key: "networking"
      naming_convention:
        name_mask: "{name}"
      name: "ava-demo-connect-prd-vpngatewayconn-01"
      type: "ExpressRoute"
      virtual_network_gateway_key: "vng1"
      express_route_authorization_key: "auth_key_from_er_circuit_owner"
      express_route_circuit_id: "er_resource_id"
    # TODO VPN IPSec
    vngconn2:
      enabled: false
      resource_group_key: "networking"
      naming_convention:
        name_mask: "{name}"
      name: "ava-demo-connect-prd-vpngatewayconn-02"
      type: "Vpn"
      virtual_network_gateway_key: "vng1"
      local_network_gateway_key: "lng1"

```

## Example Module Reference

```yaml
module "virtual_network_gateway_connections" {
  source = "[[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]//modules/networking/virtual_network_gateway_connection"
  for_each = {
    for key, value in try(local.settings.networking.virtual_network_gateway_connections, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings                 = local.settings
  resource_group_name             = local.resource_groups[each.value.resource_group_key].name
  settings                        = each.value
  virtual_network_gateway_id      = try(module.virtual_network_gateways[each.value.virtual_network_gateway_key].id, null)
  local_network_gateway_id        = try(module.local_network_gateways[try(each.value.local_network_gateway_key, null)].id, null)
  express_route_circuit_id        = try(each.value.express_route_circuit_id, null)
  express_route_authorization_key = try(each.value.express_route_authorization_key, null)
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
| [azurerm_virtual_network_gateway_connection.vngwc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_express_route_authorization_key"></a> [express\_route\_authorization\_key](#input\_express\_route\_authorization\_key) | The authorization key associated with the Express Route Circuit. This field is required only if the type is an ExpressRoute connection. | `string` | `null` | no |
| <a name="input_express_route_circuit_id"></a> [express\_route\_circuit\_id](#input\_express\_route\_circuit\_id) | The ID of the Express Route Circuit when creating an ExpressRoute connection (i.e. when type is ExpressRoute). The Express Route Circuit can be in the same or in a different subscription. | `string` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object | `any` | n/a | yes |
| <a name="input_local_network_gateway_id"></a> [local\_network\_gateway\_id](#input\_local\_network\_gateway\_id) | The ID of the local network gateway when creating Site-to-Site connection (i.e. when type is IPsec). | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. If ommitted, default value is var.global\_settings.location. | `string` | `null` | no |
| <a name="input_peer_virtual_network_gateway_id"></a> [peer\_virtual\_network\_gateway\_id](#input\_peer\_virtual\_network\_gateway\_id) | The ID of the peer virtual network gateway when creating a VNet-to-VNet connection (i.e. when type is Vnet2Vnet). The peer Virtual Network Gateway can be in the same or in a different subscription. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resource is created | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration settings object for the Virtual Network Gateway Connection resource | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the resource | `map` | `{}` | no |
| <a name="input_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#input\_virtual\_network\_gateway\_id) | The ID of the Virtual Network Gateway in which the connection will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Virtual Network Gateway Connection |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Virtual Network Gateway Connection |
<!-- END_TF_DOCS -->