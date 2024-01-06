
output "id" {
  description = "The Load Balancer Probe ID"
  value       = azurerm_lb_probe.probe.id
}
output "name" {
  description = "The Load Balancer Probe Name"
  value       = azurerm_lb_probe.probe.name
}
