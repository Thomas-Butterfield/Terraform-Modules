output "name_result" {
  description = "The Name of the resource referencing this module"
  value       = local.name_result
}

output "name_result_temp" {
  description = "The Temporary Name for the resource referencing this module"
  value       = local.name_result_temp
}

output "name_mask" {
  description = "The Name Mask used to build the output.name_result"
  value       = var.name_mask
}

output "delimiter" {
  description = "The Name Mask Delimiter used to build the output.name_result"
  value       = local.delimiter
}

output "postfix" {
  description = "The Name Mask Postfix (usually an integer) used to build the output.name_result"
  value       = local.postfix
}
