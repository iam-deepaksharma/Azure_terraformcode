variable "vm_var" {
  type = map(any)
}

resource "azurerm_resource_group" "blockrg" {
  for_each = var.vm_var
  name     = each.value.resource_group_name
  location = each.value.location
}

resource "azurerm_virtual_network" "blockvnet" {
  depends_on = [ azurerm_resource_group.blockrg ]
  for_each            = var.vm_var
  name                = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = ["10.1.0.0/24"]
}

resource "azurerm_subnet" "blocksubnet" {
  depends_on = [ azurerm_virtual_network.blockvnet ]
  for_each             = var.vm_var
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  address_prefixes     = ["10.1.0.0/26"]
  virtual_network_name = each.value.virtual_network_name
}

resource "azurerm_public_ip" "blockpip" {
  depends_on = [ azurerm_resource_group.blockrg ]
  for_each            = var.vm_var
  name                = "publicip-demon"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "blocknic" {
  for_each            = var.vm_var
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  ip_configuration {
    name                          = "publicips"
    subnet_id                     = azurerm_subnet.blocksubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.blockpip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "blocklinux" {
  depends_on = [ azurerm_public_ip.blockpip ]
  for_each              = var.vm_var
  name                  = each.value.vm_name
  resource_group_name   = each.value.resource_group_name
  location              = each.value.location
  size                  = each.value.size
  admin_username        = "azureuser"
  admin_password        = "Tulsaking@123"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.blocknic[each.key].id]

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
