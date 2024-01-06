
data "azurerm_images" "images" {
  resource_group_name = var.settings.rg_name
  # tags_filter          = try(var.settings.tags_filter, null)
}
