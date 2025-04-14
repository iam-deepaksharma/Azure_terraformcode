provider "azurerm" {
  features {

  }
  subscription_id = "76bdaab4-5692-4774-a721-2274039db83b"
}
resource "azurerm_resource_group" "rgblock" {
  name     = "rgprod"
  location = "centralindia"
}
resource "azurerm_virtual_network" "vnetblock" {
  name                = "vnetprod"
  resource_group_name = azurerm_resource_group.rgblock.name
  location            = azurerm_resource_group.rgblock.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "subnetblock" {
  name                 = "subnetprod"
  resource_group_name  = azurerm_resource_group.rgblock.name
  virtual_network_name = azurerm_virtual_network.vnetblock.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_interface" "nicblock" {
  name                = "nicprod"
  resource_group_name = "rgprod"
  location            = azurerm_resource_group.rgblock.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetblock.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "vmblock" {
  name                = "prod01_centralindia"
  resource_group_name = azurerm_resource_group.rgblock.name
  location            = azurerm_resource_group.rgblock.location
  size                = "Standard"

  admin_username                  = "azureuser"
  admin_password                  = "Tulsaking@123"
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.nicblock.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.4-LTS"
    version   = "latest"
  }
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo Hello, World!"
  }
}


resource "azurerm_resource_group" "rgblock" {
  name     = "prod"
  location = "centralindia"
}

resource "azurerm_storage_account" "storagelock" {
  name                     = "storagestage"
  resource_group_name      = azurerm_resource_group.rgblock.name
  location                 = azurerm_resource_group.rgblock.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "containerblock" {
  name                  = "prod"
  storage_account       = azurerm_azure_storage_account.storageblock.name
  container_access_type = "private"
}

resource "azurerm_storage_table" "tableblock" {
  name                = "prodtable"
  storage_account_name = azurerm_storage_account.storageblock.name
}

resource "azurerm_storage_queue" "queueblock" {
  name                 = "prodqueue"
  storage_account_name = azurerm_storage_account.storageblock.name
}
resource "azurerm_storage "
