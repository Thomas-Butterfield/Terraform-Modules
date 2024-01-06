locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lbrule}{delimiter}{postfix}"
}

module "resource_naming_lb_rule" {
  source          = "../../../resource_naming"
  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_lb_rule"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_lb_rule" "rule" {

  name                           = try(var.settings.frontend_port, null) == null ? "${module.resource_naming_lb_rule.name_result}-All" : "${module.resource_naming_lb_rule.name_result}-${var.settings.frontend_port}"
  loadbalancer_id                = var.loadbalancer_id
  protocol                       = var.settings.protocol
  frontend_port                  = try(var.settings.frontend_port, 0)
  backend_port                   = try(var.settings.backend_port, 0)
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  backend_address_pool_ids       = try(var.backend_address_pool_ids, null)
  probe_id                       = try(var.probe_id, null)
  enable_floating_ip             = try(var.settings.enable_floating_ip, null)
  idle_timeout_in_minutes        = try(var.settings.idle_timeout, null)
  load_distribution              = try(var.settings.load_distribution, null)
  disable_outbound_snat          = try(var.settings.disable_outbound_snat, null)
  enable_tcp_reset               = try(var.settings.enable_tcp_reset, null)
}
