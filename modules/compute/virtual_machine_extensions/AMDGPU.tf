resource "azurerm_virtual_machine_extension" "AmdGpuDriverWindows" {
  for_each             = var.extension_name == "AmdGpuDriverWindows" ? toset(["enabled"]) : toset([])
  name                 = "AmdGpuDriverWindows"
  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.HpcCompute"
  type                 = "AmdGpuDriverWindows"
  type_handler_version = "1.0"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}