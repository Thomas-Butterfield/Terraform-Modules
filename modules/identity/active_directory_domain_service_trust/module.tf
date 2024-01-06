
locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_active_directory_domain_service_trust"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_active_directory_domain_service_trust" "aaddstrust" {

  name                   = module.resource_naming.name_result
  password               = coalesce(var.password, try(var.settings.password, null))
  trusted_domain_dns_ips = var.settings.trusted_domain_dns_ips
  trusted_domain_fqdn    = var.settings.trusted_domain_fqdn

  domain_service_id = coalesce(
    try(var.domain_service_id, null),
    try(var.settings.domain_service_id, null)
  )
}
