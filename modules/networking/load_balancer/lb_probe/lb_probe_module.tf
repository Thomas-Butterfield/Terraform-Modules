locals {
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lbprobe}{delimiter}{postfix}"
}

module "resource_naming_lb_probe" {
  source          = "../../../resource_naming"
  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_lb_probe"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_lb_probe" "probe" {
  name                = "${module.resource_naming_lb_probe.name_result}-${var.settings.port}"
  loadbalancer_id     = var.loadbalancer_id
  port                = var.settings.port
  protocol            = var.settings.protocol
  request_path        = var.settings.protocol == "Https" || var.settings.protocol == "Http" ? var.settings.request_path : null
  interval_in_seconds = try(var.settings.interval_in_seconds, null)
  number_of_probes    = try(var.settings.number_of_probes, null)
}
