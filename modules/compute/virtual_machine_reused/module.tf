
data "azurerm_virtual_machine" "vm" {
  name                = var.settings.name
  resource_group_name = var.settings.rg_name
}
