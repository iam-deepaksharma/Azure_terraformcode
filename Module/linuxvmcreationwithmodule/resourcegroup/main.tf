variable "rg_variable" {}

resource "azurerm_resource_group" "rgblock" {
  for_each = var.rg_variable
  name     = each.value.name
  location = each.value.location
}
