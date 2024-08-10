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

resource "azurerm_public_ip" "pipblock" {
  name                = "publicip-prod"
  location            = "eastus"
  resource_group_name = "rg-prod"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nicblock" {
  name                = "nic-prod"
  resource_group_name = "rg-prod"
  location            = "eastus"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/1e4b247d-b83e-4eaa-b29d-6c362d978b02/resourceGroups/rg-prod/providers/Microsoft.Network/virtualNetworks/vnet-prod/subnets/subnet-prod"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipblock.id
  }
}

resource "azurerm_linux_virtual_machine" "vmblock" {
  name                  = "vm-prod"
  resource_group_name   = "rg-prod"
  location              = "centralindia"
  size                  = "Standard_F2"
  admin_username        = "azureuser"
  admin_password        = "Tulsaking@123"
  network_interface_ids = [azurerm_network_interface.nicblock.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "22_04_lts"
    version   = "latest"
  }
}



