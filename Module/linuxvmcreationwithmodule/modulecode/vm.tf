resource "azurerm_public_ip" "pipblock" {
  name                = "publicip-prod"
  location            = "centralindia"
  resource_group_name = "rg-prod"
  allocation_method   = "Dynamic"
}

data "azurerm_subnet" "frontend_subnetblock" {
  name                 = "subnet-prod"
  virtual_network_name = "vnet-prod"
  resource_group_name  = "rg-prod"
}

resource "azurerm_network_interface" "nicblock" {
  name                = "nic-prod"
  resource_group_name = "rg-prod"
  location            = "centralindia"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.frontend_subnetblock.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pipblock.id
  }
}

# # data "azurerm_key_vault" "kvblock" {
# #   name                = "key-password"
# #   resource_group_name = "rg-prod"
# # }

# # data "azurerm_key_vault_secret" "kv-secretblock" {
# #   name         = "key-password_username" # Get from keyvault portal
# #   key_vault_id = data.azurerm_key_vault.kvblock.id
# # }

# # data "azurerm_key_vault_secret" "kv-secretblock" {
# #   name         = "key-password_password" # Get from keyvault portal
# #   key_vault_id = data.azurerm_key_vault.kvblock.id
# # }

resource "azurerm_linux_virtual_machine" "vmblock" {
  name                            = "vm-prod"
  resource_group_name             = "rg-prod"
  location                        = "centralindia"
  size                            = "Standard_F2"
  admin_username                  = "azureuser"
  admin_password                  = "Tulsaking@123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nicblock.id]

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
