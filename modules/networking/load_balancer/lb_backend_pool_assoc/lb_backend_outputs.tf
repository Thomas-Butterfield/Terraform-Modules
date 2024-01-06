
output "id" {
  description = "The Load Balancer Backend Address Pool Network Association ID"
  value       = azurerm_network_interface_backend_address_pool_association.bap_assoc.id
}
