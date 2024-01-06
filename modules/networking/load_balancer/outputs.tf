## primary lb resource output
output "id" {
  description = "The Load Balancer ID"
  value       = azurerm_lb.lb.id
}

output "name" {
  description = "The Load Balancer Name"
  value       = azurerm_lb.lb.name
}

## this is an object type output block as documented at https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb
output "lb_frontend_ip_configuration" {
  description = "The Load Balancer Frontend IP Configuration object"
  value       = azurerm_lb.lb.frontend_ip_configuration
}

output "lb_private_ip_address" {
  description = "The Load Balancer Frontend IP Configuration Private IP Address"
  value       = azurerm_lb.lb.private_ip_address
}

## backend address pool resource output
output "lb_backend_addr_pool_id" {
  description = "The Load Balancer Backend Address Pool ID"
  value       = azurerm_lb_backend_address_pool.bap.id
}

output "lb_backend_addr_pool_ip_config" {
  description = "The Load Balancer Backend IP Configuration object"
  value       = azurerm_lb_backend_address_pool.bap.backend_ip_configurations
}

output "lb_backend_addr_pool_rules" {
  description = "The Load Balancer Backend Address Pool Rules"
  value       = azurerm_lb_backend_address_pool.bap.load_balancing_rules
}

output "lb_backend_addr_pool_nat_rules" {
  description = "The Load Balancer Backend Address Pool NAT Rules"
  value       = azurerm_lb_backend_address_pool.bap.inbound_nat_rules
}

output "lb_backend_addr_pool_out_rules" {
  description = "The Load Balancer Backend Address Pool Outbound Rules"
  value       = azurerm_lb_backend_address_pool.bap.outbound_rules
}

output "lb_probe" {
  description = "The Load Balancer Probe object"
  value       = module.lb_probe
}

output "lb_rules" {
  description = "The Load Balancer Rules"
  value       = module.load_balancer_rule
}

output "azurerm_network_interface_backend_address_pool_association_id" {
  description = "The Load Balancer Backend Address Pool Association ID"
  value       = module.lb_backend_pool_assoc
}
