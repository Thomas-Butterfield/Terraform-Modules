output "id" {
  description = "The ID of the Application Security Group"
  value       = data.azurerm_application_security_group.asg.id
}
output "name" {
  description = "The Name of the Application Security Group"
  value       = data.azurerm_application_security_group.asg.name
}
