locals {
  tags                     = merge(var.global_settings.tags, var.tags, try(var.settings.tags, null))
  naming_combined_settings = merge(var.settings, { name = "${var.resource_name}" })
  # Postfix not needed as we are appending the key
  #name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{privateendpoint}{delimiter}{name}"
  name_mask = "{privateendpoint}{delimiter}{name}"
}

module "resource_naming" {
  source = "../../../../resource_naming"

  global_settings = var.global_settings
  settings        = local.naming_combined_settings
  resource_type   = "azurerm_private_endpoint"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_private_endpoint" "pep" {

  name = var.settings.name
  #name                          = format("%s${module.resource_naming.delimiter}%s", module.resource_naming.name_result, replace(var.subresource_name, " ", "-"))
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  tags                          = local.tags
  custom_network_interface_name = var.settings.nic_name


  private_service_connection {
    name                           = format("%s${module.resource_naming.delimiter}%s", var.settings.private_service_connection.name, replace(var.subresource_name, " ", "-"))
    private_connection_resource_id = var.resource_id
    is_manual_connection           = try(var.settings.private_service_connection.is_manual_connection, false)
    subresource_names              = [var.subresource_name]
    request_message                = try(var.settings.private_service_connection.request_message, null)
  }

  private_dns_zone_group {
    name                 = var.settings.private_service_connection.private_dns_zone_name
    private_dns_zone_ids = [var.settings.private_service_connection.private_dns_zone_id]
  }

  lifecycle {
    ignore_changes = [
      resource_group_name, location
    ]
  }
}
