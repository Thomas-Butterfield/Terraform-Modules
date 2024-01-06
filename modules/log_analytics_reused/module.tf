data "azurerm_log_analytics_workspace" "law" {
  name                = var.name
  resource_group_name = var.resource_group_name
  provider            = azurerm.sharedsvc_provider
}