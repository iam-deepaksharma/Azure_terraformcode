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
resource "azurerm_resource_group" "resourcegroupblock" {
  name     = "resourcegroup-production"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnetblock" {
  name                = "vnet-production"
  resource_group_name = "resourcegroup-production"
  address_space       = ["10.1.0.0/24"]
  location            = "eastus"
}

resource "azurerm_subnet" "subnetblock" {
  name                 = "subnet-production"
  address_prefixes     = ["10.1.0.0/26"]
  resource_group_name  = "resourcegroup-production"
  virtual_network_name = "vnet-production"
}

resource "azurerm_network_interface" "nicblock" {
  name                = "nic-production"
  resource_group_name = "resourcegroup-production"
  location            = "eastus"

  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.subnetblock.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vmblock" {
  name                  = "linuxvm-production"
  resource_group_name   = "resourcegroup-production"
  location              = "centralindia"
  size                  = "Standard_F2"
  network_interface_ids = [azurerm_network_interface.nicblock.id]
  admin_username        = "azureuser"
  admin_password        = "Tulsaking@123"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy" 
    sku       = "22_04-lts"
    version   = "latest"
    
  }
}
