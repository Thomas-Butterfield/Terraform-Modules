module "private_dns" {
  source   = "../private_dns"
  for_each = try(var.settings.private_dns, {})

  global_settings      = var.global_settings
  settings             = each.value
  resource_group_name  = var.resource_group_name
  vnet_id              = var.vnet_id
  records              = each.value.private_dns_records
  private_ip_addresses = [azurerm_private_endpoint.pep.private_service_connection.0.private_ip_address]
  resource_name        = var.resource_name
  # Pass tags from private endpoint
  tags = local.tags
}
