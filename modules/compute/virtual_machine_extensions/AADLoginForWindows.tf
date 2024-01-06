resource "azurerm_virtual_machine_extension" "AADLoginForWindows" {
  for_each                   = var.extension_name == "AADLoginForWindows" ? toset(["enabled"]) : toset([])
  name                       = "AADLoginForWindows"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)
  automatic_upgrade_enabled  = try(var.extension.automatic_upgrade_enabled, false)

  settings = <<-SETTINGS
    {
      "mdmId": "0000000a-0000-0000-c000-000000000000"
    }
    SETTINGS

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

locals {
  AADJPrivate_ShutdownCmd = "shutdown -r -t 10"
  AADJPrivate_ExitCode    = "exit 0"
  AADJPrivate_CmdToRun    = "New-Item -Path HKLM:/SOFTWARE/Microsoft/RDInfraAgent/AADJPrivate"
  AADJPrivate_PS_Command  = "${local.AADJPrivate_CmdToRun}; ${local.AADJPrivate_ShutdownCmd}; ${local.AADJPrivate_ExitCode}"
}

resource "azurerm_virtual_machine_extension" "AADJPrivate" {
  depends_on = [
    azurerm_virtual_machine_extension.AADLoginForWindows
  ]
  for_each             = var.extension_name == "AADLoginForWindows" ? toset(["enabled"]) : toset([])
  name                 = "AADJPrivate"
  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell.exe -Command \"${local.AADJPrivate_PS_Command}\""
    }
  SETTINGS

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
