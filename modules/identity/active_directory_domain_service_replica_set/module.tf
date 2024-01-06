
resource "azurerm_active_directory_domain_service_replica_set" "aaddsrs" {

  location = var.location != null ? var.location : var.global_settings.location

  domain_service_id = coalesce(
    try(var.domain_service_id, null),
    try(var.settings.domain_service_id, null)
  )

  subnet_id = coalesce(
    try(var.virtual_networks[var.settings.subnet.vnet_key].subnets[var.settings.subnet.subnet_key].id, null),
    try(var.settings.subnet_id, null)
  )

  lifecycle {
    ignore_changes = [
      subnet_id
    ]
  }

}
