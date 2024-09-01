# 07.Weekly Assignement:Manually Create a Resource Group (RG) in Azure Portal
# resource "azurerm_resource_group" "rgblock" {
#   name     = "cokestudiobydeepak"
#   location = "southindia"
# }

# ===================================================================================================================================

# 09.Weekly Assignment:Terraform Assignment: list variable

# variable "rg_list" {
#   description = "List of resource groups"
#   type        = list(string)
#   default     = ["rg1", "rg2", "rg3", "rg4"]
# }

# variable "location" {
#   description = "Location for the resource groups"
#   type        = string
#   default     = "centralindia"
# }

# resource "azurerm_resource_group" "rg" {
#   for_each = toset(var.rg_list)
#   name     = each.value
#   location = var.location
# }

# Terraform Assignment: set variable

# variable "rg_set" {
#   description = "List of resource groups"
#   type        = set(string)
#   default     = ["rg1", "rg2", "rg3", "rg4", "rg2", "rg3"]
# }

# variable "location" {
#   description = "Location for the resource groups"
#   type        = string
#   default     = "centralindia"
# }

# resource "azurerm_resource_group" "rg" {
#   for_each = var.rg_set
#   name     = each.value
#   location = var.location
# }

# ================================================================================================================================