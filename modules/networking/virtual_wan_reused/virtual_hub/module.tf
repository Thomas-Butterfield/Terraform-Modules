
data "azurerm_virtual_hub" "vwan_hub" {
  name                = try(var.virtual_hub.name, null)
  resource_group_name = try(var.virtual_hub.rg_name, null)
  provider            = azurerm.vhub_provider
}
