
resource "null_resource" "upload" {
  provisioner "local-exec" {
    command = <<EOT
az storage directory create --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --share-name ${var.storage_share_name} --name ${var.storage_dir_name}
az storage directory create --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --share-name ${var.storage_share_name} --name ${var.storage_dir_name}/config
az storage directory create --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --share-name ${var.storage_share_name} --name ${var.storage_dir_name}/content
az storage directory create --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --share-name ${var.storage_share_name} --name ${var.storage_dir_name}/license
az storage directory create --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --share-name ${var.storage_share_name} --name ${var.storage_dir_name}/software


az storage file upload-batch --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --destination ${var.storage_share_name}/${var.storage_dir_name}/config  --source ${var.local_file_path}config
az storage file upload-batch --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --destination ${var.storage_share_name}/${var.storage_dir_name}/content --source ${var.local_file_path}content
az storage file upload-batch --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --destination ${var.storage_share_name}/${var.storage_dir_name}/license --source ${var.local_file_path}license
az storage file upload-batch --account-name ${var.storage_account_name} --account-key ${var.storage_account_key} --destination ${var.storage_share_name}/${var.storage_dir_name}/software --source ${var.local_file_path}software


EOT
  }
}