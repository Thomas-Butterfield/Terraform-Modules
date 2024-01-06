
resource "azurerm_site_recovery_fabric" "recovery_fabric" {
  depends_on = [time_sleep.delay_create]
  for_each   = try(var.recovery_vault.recovery_fabrics, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.asr.name
  location            = var.global_settings.regions[each.value.region]
}