
# variable "groupofrg_inlist" {
#   type    = list(string)
#   default = ["rg1", "rg2", "rg3", "rg4"]
# }


# resource "azurerm_resource_group" "RGBlockname" {
#   for_each = toset(var.groupofrg_inlist)
#   name     = each.value
#   location = "centralindia"
# }

# ================================================================================================================================

# 21-07-2024 Main Class

# variable "rg_map" {
#   type = map
#   default = {
#     rg1 = "centralindia"
#     rg2 = "westeurope"
#     rg3 = "southindia"
#   }
# }

# resource "azurerm_resource_group" "rg" {
#   for_each = var.rg_map
#   name     = each.key
#   location = each.value
# }

# ============================================================================================================================

# 22-07-2024, Variable(map)

# resource "azurerm_resource_group" "rgblock" {
#   name     = "cokestudiobydeepak"
#   location = "southindia"
# }

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
# resource "azurerm_storage_account" "example" {
#   for_each                 = var.azurerm_storage_account_map
#   name                     = each.value.name
#   resource_group_name      = each.value.resource_group_name
#   location                 = each.value.location
#   account_tier             = each.value.account_tier
#   account_replication_type = each.value.account_replication_type
# }
# 
# ==================================================================================================================================

resource "azurerm_resource_group" "rgblock" {
  name     = "cokestudiobydeepak"
  location = "southindia"
}


# resource group creation with for each

resource "azurerm_resource_group" "block" {
  for_each = {
    tulsaking  = "centralindia"
    tulsaking2 = "westindia"
  }
  name     = each.key
  location = each.value
}

# Storage account creation with for each

# resource "azurerm_storage_account" "sbblock" {
#   for_each = {
#     stg1 = {
#       name                     = "tulsakingstorage"
#       rg_name                  = "tulsaking1"
#       location                 = "westindia"
#       account_tier             = "Standard"
#       account_replication_type = "LRS"
#     }
#   }
#   name                     = each.key
#   resource_group_name      = each.value.rg_name
#   location                 = each.value.location
#   account_tier             = "Standard"
#   account_replication_type = each.value.account_replication_type
# }


# resource "azurerm_resource_group" "mainblock" {
#   rg_map = {
#     rg1 = {
#       name     = "bang1"
#       location = "centralindia"
#     }
#     rg2 = {
#       name     = "bang2"
#       location = "westindia"
#     }
#   }
# }

# resource "azurerm_storage_account" "storageblock" {
#   for_each = {
#     "stg1=" = {
#       name                     = "bangstorage"
#       location                 = "centralindia"
#       rg_name                  = "bang1"
#       account_tier             = "Standard"
#       account_replication_type = "LRS"
#     }
#   }
#   name                     = each.value.name
#   location                 = each.value.location
#   resource_group_name      = each.value.rg_name
#   account_tier             = each.value.account_tier
#   account_replication_type = each.value.account_replication_type
# }
