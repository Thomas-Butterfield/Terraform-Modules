output "id" {
  description = "The ID of the Private Endpoint"
  value       = azurerm_private_endpoint.pep.id
  # value = flatten([for subresourcename_key in toset(var.subresource_names) : try(azurerm_private_endpoint.pep[subresourcename_key].id, null)])
}

output "name" {
  description = "The Name of the Private Endpoint"
  value       = azurerm_private_endpoint.pep.name
  # value = flatten([for subresourcename_key in toset(var.subresource_names) : try(azurerm_private_endpoint.pep[subresourcename_key].name, null)])
}

output "private_ip_address" {
  description = "The Private IP Address of the Private Endpoint"
  value       = azurerm_private_endpoint.pep.private_service_connection.0.private_ip_address
  # value = flatten([for subresourcename_key in toset(var.subresource_names) : try(azurerm_private_endpoint.pep[subresourcename_key].private_service_connection.private_ip_address, null)])
}
