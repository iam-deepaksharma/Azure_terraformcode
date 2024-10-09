variable "vnet_variable" {
  type = any()
}

resource "azurerm_virtual_network" "vnetblock" {
  for_each = var.vnet_variable
  name = "vnet-prod"
  resource_group_name = "rgbydeepak"
  location = 
  address_space = 
}