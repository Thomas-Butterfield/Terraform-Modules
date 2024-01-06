terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

locals {
  os_type = lower(var.settings.os_type)
  # Generate SSH Keys only if a public one is not provided
  create_sshkeys = local.os_type == "linux" && try(var.settings.public_key_pem_file == "", true)
  tags           = merge(var.tags, var.global_settings.tags, try(var.settings.tags, null))

  application_gateway_backend_address_pool_ids = flatten([
    for nic, nic_value in var.settings.network_interfaces : [
      for appgw, appgw_value in try(nic_value.appgw_backend_pools, {}) : [
        for pool_name in appgw_value.pool_names : [
          try(var.application_gateways[appgw_value.appgw_key].backend_address_pools[pool_name], null)
        ]
      ]
    ]
  ])

  load_balancer_backend_address_pool_ids = flatten([
    for nic, nic_value in var.settings.network_interfaces : [
      for lb, lb_value in try(nic_value.load_balancers, {}) : [
        try(var.load_balancers[lb_value.lb_key].backend_address_pool_id, null)
      ]
    ]
  ])

  application_security_group_ids = flatten([
    for nic, nic_value in var.settings.network_interfaces : [
      for asg, asg_value in try(nic_value.application_security_groups, {}) : [
        try(var.application_security_groups[asg_value.asg_key].id, var.application_security_groups[asg_value.asg_key].id)
      ]
    ]
  ])

}


