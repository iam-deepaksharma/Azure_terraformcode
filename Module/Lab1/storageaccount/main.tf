resource "azurerm_storage_account" "storageblock" {
  name                     = storage-prod
  resource_group_name      = "rg-prod"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}