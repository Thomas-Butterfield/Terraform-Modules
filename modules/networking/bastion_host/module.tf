locals {
  tags      = merge(var.global_settings.tags, var.tags)
  name_mask = "{cloudprefix}{delimiter}{locationcode}{delimiter}{envlabel}{delimiter}{bastion}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.bastion_host
  resource_type   = "azurerm_bastion_host"
  name_mask       = try(var.bastion_host.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_bastion_host" "bastion" {
  name                   = module.resource_naming.name_result
  location               = var.location != null ? var.location : var.global_settings.location
  resource_group_name    = var.resource_group_name
  copy_paste_enabled     = try(var.bastion_host.copy_paste_enabled, true)
  file_copy_enabled      = try(var.bastion_host.file_copy_enabled, false)
  sku                    = try(var.bastion_host.sku, "Basic")
  ip_connect_enabled     = try(var.bastion_host.ip_connect_enabled, false)
  scale_units            = try(var.bastion_host.scale_units, 2)
  shareable_link_enabled = try(var.bastion_host.shareable_link_enabled, false)
  tunneling_enabled      = try(var.bastion_host.tunneling_enabled, false)
  tags                   = local.tags

  ip_configuration {
    name                 = try(var.bastion_host.ip_configuration.name, "ipconfig1")
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}
