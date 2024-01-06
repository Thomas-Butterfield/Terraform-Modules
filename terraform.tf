terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    resource_group { prevent_deletion_if_contains_resources = false }
  }
}

provider "azurerm" {
  alias           = "hub_subscription"
  subscription_id = var.hub_subscription_id
  features {
    resource_group { prevent_deletion_if_contains_resources = false }
  }
}

provider "azurerm" {
  alias           = "sharedsvc_subscription"
  subscription_id = var.sharedsvc_subscription_id
  features {
    resource_group { prevent_deletion_if_contains_resources = false }
  }
}

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}