# Variable using set
# variable "groupofrg" {
#   type    = set(string)
#   default = ["rg1", "rg2", "rg3", "rg4"]
# }
# resource "azurerm_resource_group" "RGBlockname" {
#   for_each = var.groupofrg
#   name     = each.value
#   location = "centralindia"
# }


# 22-07-2024, Variable with map

# variable "azurerm_storage_account_map" {
#   type = map(any)
#   default = {
#     stg1 = {
#       name                     = "panga1"
#       resource_group_name      = "cokestudiobydeepak"
#       location                 = "centralindia"
#       account_tier             = "Standard"
#       account_replication_type = "GRS"
#     }
#     stg2 = {
#       name                     = "panga2"
#       resource_group_name      = "cokestudiobydeepak"
#       location                 = "westindia"
#       account_tier             = "Standard"
#       account_replication_type = "LRS"
#     }
#     stg3 = {
#       name                     = "panga3"
#       resource_group_name      = "cokestudiobydeepak"
#       location                 = "southindia"
#       account_tier             = "Standard"
#       account_replication_type = "GRS"
#     }
#     stg4 = {
#       name                     = "panga4"
#       resource_group_name      = "cokestudiobydeepak"
#       location                 = "eastus"
#       account_tier             = "Standard"
#       account_replication_type = "GRS"
#     }
#   }
# }

resource "azurerm_storage_account" "sbblock" {
  for_each = {
    stg1 = {
      name                     = "tulsakingstorage"
      rg_name                  = "tulsaking1"
      location                 = "westindia"
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
  }
  name                     = each.key
  resource_group_name      = each.value.rg_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = each.value.account_replication_type
}