terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.114.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "block21" {
  name     = "rain"
  location = "centralindia"
}

resource "azurerm_storage_account" "block22" {
  name                     = "storageaccountname21"
  resource_group_name      = "rain"
  location                 = "southindia"
  account_tier        = "Standard"
  account_replication_type = "LRS"
}
