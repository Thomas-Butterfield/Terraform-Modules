locals {

  #Convert YAML settings file to Terraform Configuration file format
  settings = yamldecode(file("../environments/${var.environment}/settings.yaml"))

  resource_groups = merge(module.resource_groups, module.resource_group_reused)

  appgroup = module.avd_app_groups

  log_analytics = merge(module.log_analytics, module.log_analytics_reused)

  networking = merge(module.networking, module.networking_reused, module.networking_reused_hub)

  route_tables = merge(module.route_tables, module.route_tables_reused)

  keyvaults = merge(module.keyvault, module.keyvault_reused)

  azuread_groups = merge(module.azuread_groups, module.azuread_groups_reused)

  images = merge(module.images, module.images_reused)

  virtual_machine_groups_vms = { for virtual_machine in flatten([for groups in module.virtual_machine_groups : [for k, v in groups.virtual_machines_in_group : { "key" = k, "val" = v }]]) : virtual_machine.key => virtual_machine.val }

  virtual_machines = merge(module.virtual_machines_reused, module.virtual_machines, local.virtual_machine_groups_vms)

  # Example logic to enable zones
  #regions_with_availability_zones = ["centralus","eastus2","eastus","westus","southcentralus","westus2","westus3"]
  #zones = contains(local.regions_with_availability_zones, local.settings.location) ? list("1","2","3") : null

  # Diagnostics services to create
  diagnostics = {
    # diagnostic_event_hub_namespaces = try(local.settings.diagnostic_event_hub_namespaces, {})
    # diagnostic_log_analytics        = try(local.settings.diagnostic_log_analytics, {})
    # diagnostic_storage_accounts     = try(local.settings.diagnostic_storage_accounts, {})
    # event_hub_namespaces     = try(local.settings.event_hub_namespaces, {})
    diagnostic_profiles      = try(local.settings.diagnostic_profiles, {})
    diagnostics_definition   = try(local.settings.diagnostics_definition, {})
    diagnostics_destinations = try(local.settings.diagnostics_destinations, {})
    # log_analytics            = try(module.log_analytics, {})
    # storage_accounts = try(module.storage_account, {})
  }

  # Private Endpoint Remote Objects
  privendpoint_remote_objects = {
    keyvaults        = try(module.keyvault, {})
    storage_accounts = try(module.storage_account, {})
  }

}