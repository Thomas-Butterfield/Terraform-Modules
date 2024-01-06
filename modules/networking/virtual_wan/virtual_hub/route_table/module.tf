
#===================================================================
# default_route_table can be modified in Terraform but it is
# advised to manage via CLI or Portal until more provider
# vhub attributes and sub-resources are made available.
#===================================================================
resource "azurerm_virtual_hub_route_table_route" "vhub-defaultroutetablert" {
  for_each = var.rt_table_key == "default_route_table" ? toset(["enabled"]) : toset([])

  # route_table_id = azurerm_virtual_hub.vwan_hub.default_route_table_id
  route_table_id = var.vhub.default_route_table_id

  name              = "SecureAllTraffic"
  destinations_type = "CIDR"
  # destinations      = ["0.0.0.0/0,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"]
  destinations  = var.settings.address_prefixes
  next_hop_type = "ResourceId"
  next_hop      = var.settings.next_hop == "firewall" ? var.firewall_resource_id : var.settings.next_hop_id
}

resource "azurerm_virtual_hub_route_table" "vhub-routetable" {
  for_each = var.rt_table_key != "default_route_table" ? toset(["enabled"]) : toset([])

  name           = var.settings.rt_table_name
  virtual_hub_id = var.vhub.id
  labels         = ["${var.settings.label}"]

  dynamic "route" {
    for_each = var.settings.routes
    content {
      name              = route.value.route_name
      destinations_type = "CIDR"
      destinations      = route.value.address_prefixes
      next_hop_type     = "ResourceId"
      next_hop          = route.value.next_hop == "firewall" ? var.firewall_resource_id : route.value.next_hop_id
    }
  }
}
