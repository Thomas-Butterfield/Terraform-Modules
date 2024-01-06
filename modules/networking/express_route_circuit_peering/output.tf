output "id" {
  description = "The ID of the Express Route Circuit Peering"
  value       = azurerm_express_route_circuit_peering.er_circuit_peering.id
}
output "azure_asn" {
  description = "The ASN used by Azure"
  value       = azurerm_express_route_circuit_peering.er_circuit_peering.azure_asn
}
output "primary_azure_port" {
  description = "The Primary Port used by Azure for this Peering"
  value       = azurerm_express_route_circuit_peering.er_circuit_peering.primary_azure_port
}
output "secondary_azure_port" {
  description = "The Secondary Port used by Azure for this Peering"
  value       = azurerm_express_route_circuit_peering.er_circuit_peering.secondary_azure_port
}
