terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.6.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "26c915ac-fa33-4940-9882-ca0dcabd8edc"
}

resource "azurerm_resource_group" "rgblock" {
  name = "rg-block"
  location = "uswest"
}

resource "azurerm_virtual_network" "vnetblock" {
  name = "vnet-01"
  resource_group_name = azurerm_resource_group.rgblock
  location = "uswest"
  address_space = ["10.0.0.1/16"]

}

resource "azurerm_subnet" "subnetblock" {
  name = "subnet-01"
  resource_group_name = azurerm_resource_group.rgblock
  virtual_network_name = azurerm_virtual_network_vnetblock
  address_prefixes = ["10.1.0.0/24"]
}

resource "azurerm_network_interface" "nicblock" {
    name = "nic-01"
    resource_group_name = azurerm_resource_group.rgblock
    location = "uswest"

    ip_configuration {
    name = "ipconfig"
    subnet_id = azurerm_subnet.subnetblock.id
    private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "vmblock" {
  name = "vm-01"
  resource_group_name = azurerm_resource_group_name.rgblock
  location = "uswest"
  size = "Standard_DS1_v2"
  admin_username = "azureuser"
  admin_password = "Tulsaking@123"
}