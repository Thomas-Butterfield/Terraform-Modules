terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

locals {
  os_type = lower(var.settings.os_type)
  # Generate SSH Keys only if a public one is not provided
  create_sshkeys = (local.os_type == "linux" || local.os_type == "legacy") && try(var.settings.public_key_pem_file == "", true)
  tags           = merge(var.tags, var.global_settings.tags, try(var.settings.tags, null))
}