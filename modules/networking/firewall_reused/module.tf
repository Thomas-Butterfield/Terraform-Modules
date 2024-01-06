
data "azurerm_firewall" "fw" {
  name                = var.firewall.name
  resource_group_name = var.firewall.rg_name
  # provider            = azurerm.sharedsvc_provider
}
