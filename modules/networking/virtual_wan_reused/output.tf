output "id" {
  description = "The ID of the Data Virtual WAN"
  value       = data.azurerm_virtual_wan.vwan.id
}

output "name" {
  description = "The Name of the Data Virtual WAN"
  value       = data.azurerm_virtual_wan.vwan.name
}

# output "virtual_hubs_reused" {
#   description = "The Data Virtual Hubs module object"
#   value       = module.hubs_reused
# }

output "virtual_hubs" {
  description = "The Virtual Hubs module object"
  value       = merge(module.hubs, module.hubs_reused)
}

output "virtual_wan" {
  description = "The Data Virtual WAN resource object"
  value       = data.azurerm_virtual_wan.vwan
}
