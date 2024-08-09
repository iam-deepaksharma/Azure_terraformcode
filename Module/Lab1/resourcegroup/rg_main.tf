variable "rg_details" {}
resource "azurerm_resource_group" "rgblock" {
  for_each = {}
  name = each.value.name
  location = each.value.location
}