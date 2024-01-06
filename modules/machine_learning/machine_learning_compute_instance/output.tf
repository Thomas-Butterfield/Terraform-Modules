output "id" {
  description = "The ID of the Machine Learning Compute Instance"
  value       = azurerm_machine_learning_compute_instance.mlci.id
}
output "name" {
  description = "The Name of the Machine Learning Compute Instance"
  value       = azurerm_machine_learning_compute_instance.mlci.name
}
output "identity" {
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Machine Learning Compute Instance"
  value       = azurerm_machine_learning_compute_instance.mlci.identity
}
output "ssh" {
  description = "An `ssh` block as defined below, which specifies policy and settings for SSH access for this Machine Learning Compute Instance"
  value       = azurerm_machine_learning_compute_instance.mlci.ssh
}
