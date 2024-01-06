locals {
  name_mask = "{name}"
}

module "resource_naming" {
  source = "../../resource_naming"

  global_settings = var.global_settings
  settings        = var.settings
  resource_type   = "azurerm_servicebus_topic"
  name_mask       = try(var.settings.naming_convention.name_mask, local.name_mask)
}

resource "azurerm_servicebus_topic" "topic" {
  name                                    = module.resource_naming.name_result
  namespace_id                            = var.servicebus_namespace_id
  status                                  = try(var.settings.status, "Active")
  auto_delete_on_idle                     = try(var.settings.auto_delete_on_idle, null)
  default_message_ttl                     = try(var.settings.default_message_ttl, null)
  duplicate_detection_history_time_window = try(var.settings.duplicate_detection_history_time_window, "PT10M")
  enable_batched_operations               = try(var.settings.enable_batched_operations, false)
  enable_express                          = try(var.settings.enable_express, null)
  enable_partitioning                     = try(var.settings.enable_partitioning, false)
  max_message_size_in_kilobytes           = try(var.settings.max_message_size_in_kilobytes, null)
  max_size_in_megabytes                   = try(var.settings.max_size_in_megabytes, null)
  requires_duplicate_detection            = try(var.settings.requires_duplicate_detection, null)
  support_ordering                        = try(var.settings.support_ordering, false)
}

module "topic_auth_rules" {
  source   = "./topic_auth_rule"
  for_each = try(var.settings.topic_auth_rules, {})

  global_settings     = var.global_settings
  settings            = each.value
  servicebus_topic_id = azurerm_servicebus_topic.topic.id
}

module "topic_subscriptions" {
  source   = "./subscription"
  for_each = try(var.settings.subscriptions, {})

  global_settings     = var.global_settings
  settings            = each.value
  servicebus_topic_id = azurerm_servicebus_topic.topic.id
  servicebus_queues   = var.servicebus_queues
  servicebus_topics   = var.servicebus_topics
}
