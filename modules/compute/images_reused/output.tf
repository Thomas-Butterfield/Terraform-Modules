output "images" {
  description = "One or more images blocks"
  value       = data.azurerm_images.images.images
}
