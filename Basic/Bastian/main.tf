terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "azurerm_resource_group" "blockrg" {
  name     = "rg-bastian"
  location = "southindia"
}

resource "azurerm_key_vault" "example" {
  name                        = "bastian-keyvaultlab"
  location                    = azurerm_resource_group.blockrg.location
  resource_group_name         = azurerm_resource_group.blockrg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.clientblock.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
enable_rbac_authorization = true
  access_policy {
    tenant_id = data.azurerm_client_config.clientblock.tenant_id
    object_id = data.azurerm_client_config.clientblock.object_id

    secret_permissions = [
      "Get", "List", "Set"
    ]
  }
}

resource "azurerm_key_vault_secret" "usernameblock" {
  name         = "bastionusernamelab"
  value        = "azureuser"
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_key_vault_secret" "passwordblock" {
  name         = "bastionpasswordlab"
  value        = "Tulsaking@123"
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_virtual_network" "block2" {
  depends_on          = [azurerm_resource_group.blockrg]
  name                = "vnet-vm"
  resource_group_name = azurerm_resource_group.blockrg.name
  location            = azurerm_resource_group.blockrg.location
  address_space       = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "block3" {
  depends_on           = [azurerm_virtual_network.block2]
  name                 = "subnet-vm"
  resource_group_name  = azurerm_resource_group.blockrg.name
  virtual_network_name = azurerm_virtual_network.block2.name
  address_prefixes     = ["10.0.1.0/26"]
}

resource "azurerm_subnet" "bastiansubnetblock" {
    depends_on = [ azurerm_virtual_network.block2 ]
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.blockrg.name
  virtual_network_name = azurerm_virtual_network.block2.name
  address_prefixes     = ["10.0.1.64/26"]
}

resource "azurerm_public_ip" "block6" {
  name                = "publicip-vm"
  resource_group_name = azurerm_resource_group.blockrg.name
  location            = azurerm_resource_group.blockrg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "block4" {
    depends_on = [ azurerm_resource_group.blockrg ]
  name                = "nic-vm"
  resource_group_name = azurerm_resource_group.blockrg.name
  location            = azurerm_resource_group.blockrg.location

  ip_configuration {
    name                          = "internal-ip"
    subnet_id                     = azurerm_subnet.block3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.block6.id
  }
}

# data "azurerm_key_vault" "kvblock" {
#   name = "credential-lab"
#   resource_group_name = azurerm_resource_group.blockrg.name
# }
# data "azurerm_key_vault_secret" "usernameblock" {
#   name = "vm-username"
#   key_vault_id = data.azurerm_key_vault.kvblock.id
# }
# data "azurerm_key_vault_secret" "passwordblock" {
#   name = "vm-password"
#   key_vault_id = data.azurerm_key_vault.kvblock.id
# }

resource "azurerm_linux_virtual_machine" "block5" {
  depends_on                      = [azurerm_network_interface.block4]
  name                            = "linux-vm"
  resource_group_name             = azurerm_resource_group.blockrg.name
  location                        = azurerm_resource_group.blockrg.location
  size                            = "Standard_F2"
  admin_username                  = "azureuser"
  admin_password                  = "Tulsaking@123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.block4.id]

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

