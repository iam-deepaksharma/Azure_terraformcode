variable "vnet_variable" {}
resource "azurerm_virtual_network" "vnetblock" {
  for_each = var.vnet_variable
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
}

