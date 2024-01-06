
data "azurerm_route_table" "rt" {
  name                = var.settings.name
  resource_group_name = var.settings.rg_name
}
