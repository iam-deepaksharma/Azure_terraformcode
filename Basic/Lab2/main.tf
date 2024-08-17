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

resource "azurerm_resource_group" "block1" {
  name     = "rg-pipeline"
  location = "centralindia"
}

resource "azurerm_storage_account" "block2" {
  name                     = "storagecontainerlab"
  resource_group_name      = "rg-pipeline"
  location                 = "centralindia"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
