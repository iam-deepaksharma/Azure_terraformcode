variable "sa_variable" {
  default = {
    sa1 = {
      name                     = "samodule"
      resource_group_name      = "rg-module"
      location                 = "centralindia"
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
  }
}

resource "azurerm_storage_account" "storageblock" {
  for_each = var.sa_variable
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}
