data "azurerm_application_security_group" "asg" {
  name                = var.settings.name
  resource_group_name = var.settings.rg_name
}
