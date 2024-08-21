terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-lab"           # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "duedatelab"       # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "pipelinetfstate"  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "pipeline.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {

  }
}
resource "azurerm_resource_group" "block" {
  name     = "rg-lab"
  location = "westindia"
}

resource "azurerm_storage_account" "block2" {
  name                     = "duedatelab"
  resource_group_name      = azurerm_resource_group.block.name
  location                 = azurerm_resource_group.block.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
