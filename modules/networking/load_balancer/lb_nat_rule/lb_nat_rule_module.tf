locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lbrule}{delimiter}{postfix}"
}

module "resource_naming_lb_nat_rule" {
  source          = "../../../resource_naming"
  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_lb_nat_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}
resource "azurerm_lb_nat_rule" "natrule" {

  name                           = module.resource_naming_lb_nat_rule.name_result
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = var.loadbalancer_id
  protocol                       = var.settings.lb_nat_rule_protocol
  frontend_port                  = try(var.settings.frontend_port, null)
  backend_port                   = try(var.settings.backend_port, 0)
  frontend_port_start            = try(var.settings.frontend_port_start, null)
  frontend_port_end              = try(var.settings.frontend_port_end, null)
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  backend_address_pool_id        = try(var.backend_address_pool_id, null)
  enable_floating_ip             = try(var.settings.enable_floating_ip, null)
  idle_timeout_in_minutes        = try(var.settings.lb_nat_rule_idle_timeout, null)
  enable_tcp_reset               = try(var.settings.enable_tcp_reset, null)

}

