resource "azurerm_resource_group" "block1" {
  name     = "idc-prod"
  location = "centralindia"
}

resource "azurerm_virtual_network" "block2" {
  depends_on = [ azurerm_resource_group.block1 ]
  name                = "idc-vnet"
  address_space       = ["10.0.0.0/24"]
  resource_group_name = azurerm_resource_group.block1.name
  location            = azurerm_resource_group.block1.location
}

resource "azurerm_subnet" "block3" {
  depends_on = [ azurerm_virtual_network.block2 ]
  name                 = "idc-subnet"
  resource_group_name  = azurerm_resource_group.block1.name
  address_prefixes     = ["10.0.0.0/26"]
  virtual_network_name = azurerm_virtual_network.block2.name
}

resource "azurerm_public_ip" "block6" {
  name = "idc-pip"
  resource_group_name = azurerm_resource_group.block1.name
  location = azurerm_resource_group.block1.location
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "block4" {
  name                = "idc-nic"
  resource_group_name = azurerm_resource_group.block1.name
  location            = azurerm_resource_group.block1.location

  ip_configuration {
    name                          = "Internal"
    subnet_id                     = azurerm_subnet.block3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "block5" {
  name                  = "idc-linux"
  resource_group_name   = azurerm_resource_group.block1.name
  location              = azurerm_resource_group.block1.location
  size                  = "Standard_F2"
  admin_username        = "azureuser"
  admin_password        = "Tulsaking@123"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.block4.id ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "Latest"
  }
}
