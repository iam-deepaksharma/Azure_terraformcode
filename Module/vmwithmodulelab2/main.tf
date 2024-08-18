terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "blockrg" {
  name = "rg-dev"
  location = "southinia"
}

