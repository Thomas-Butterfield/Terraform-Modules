
data "azurerm_firewall_policy" "fwpol" {
  name                = var.firewall_policy.name
  resource_group_name = var.firewall_policy.rg_name
}
