locals {
  tags      = merge(var.tags, var.global_settings.tags, try(var.settings.tags, null))
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{lb}{delimiter}{postfix}"
}

module "resource_naming_lb" {
  source          = "../../resource_naming"
  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_lb"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_lb" "lb" {
  # required arguments
  name                = module.resource_naming_lb.name_result
  resource_group_name = var.resource_group_name
  location            = var.location != null ? var.location : var.global_settings.location

  # optional arguments
  sku      = try(var.settings.sku, "Basic")
  sku_tier = try(var.settings.sku_tier, "Regional")
  tags     = local.tags

  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend, {})

    content {
      name = try(frontend_ip_configuration.value.name, null) != null ? frontend_ip_configuration.value.name : "${module.resource_naming_lb.name_result}-fe_ip_name"
      # zones                         = try(frontend_ip_configuration.value.availability_zones), null) != null ? frontend_ip_configuration.value.availability_zones : null
      public_ip_address_id          = try(lower(var.settings.type), "private") == "public" ? var.public_ips[frontend_ip_configuration.value.pip_key].id : null
      subnet_id                     = try(lower(var.settings.type), "private") == "public" ? null : try(var.virtual_networks[frontend_ip_configuration.value.vnet_key].subnets[frontend_ip_configuration.value.subnet_key].id, var.subnet_id)
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address, null) == null ? "Dynamic" : "Static"
      private_ip_address            = try(frontend_ip_configuration.value.private_ip_address, null) == null ? null : frontend_ip_configuration.value.private_ip_address

      # gateway sku only
      gateway_load_balancer_frontend_ip_configuration_id = try(var.settings.sku, "Basic") == "Gateway" ? var.gateway_fe_ip_id : null
    }
  }
}

resource "azurerm_lb_backend_address_pool" "bap" {
  name            = "${module.resource_naming_lb.name_result}-BACKENDPOOL"
  loadbalancer_id = azurerm_lb.lb.id
}

module "lb_probe" {
  source = "./lb_probe"

  for_each = {
    for key, value in try(var.settings.probes, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings = var.global_settings
  settings        = each.value
  loadbalancer_id = azurerm_lb.lb.id
}

module "load_balancer_rule" {
  source = "./lb_rule"

  for_each = {
    for key, value in try(var.settings.rules, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings                = var.global_settings
  settings                       = each.value
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[each.value.frontend_key].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bap.id]
  probe_id                       = module.lb_probe[each.value.probe_key].id
}

module "lb_nat_rule" {
  source = "./lb_nat_rule"

  for_each = {
    for key, value in try(var.settings.nat_rules, {}) : key => value
    if try(value.enabled, false) == true
  }

  global_settings                = var.global_settings
  settings                       = each.value
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[each.value.frontend_key].name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bap.id

}

module "lb_backend_pool_assoc" {
  source = "./lb_backend_pool_assoc"

  for_each = {
    for key, value in try(var.settings.backend_pool_assoc, {}) : key => value
    if try(value.enabled, false) == true
  }

  network_interface_id    = var.backend_resources[each.value.resource_key].nics[each.value.nic_id_key].id
  ip_configuration_name   = var.backend_resources[each.value.resource_key].nics[each.value.nic_id_key].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.bap.id
}
