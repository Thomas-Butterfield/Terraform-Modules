output "id" {
  description = "The ID of the AVD host pool"
  value       = azurerm_virtual_desktop_host_pool.avdpool.id
}

output "name" {
  description = "The Name of the AVD host pool"
  value       = azurerm_virtual_desktop_host_pool.avdpool.name
}

output "token" {
  description = "The Registration Token of the AVD host pool"
  value       = tostring(try(azurerm_virtual_desktop_host_pool_registration_info.registration_info[0].token, null))
  sensitive   = true
}
