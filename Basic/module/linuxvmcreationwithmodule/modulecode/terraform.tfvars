rg_final = {
  rg1 = {
    name     = "rg-prod"
    location = "centralindia"
  }
}
vnet_final = {
  vnet = {
    name                = "vnet-prod"
    resource_group_name = "rg-prod"
    address_space       = ["10.1.0.0/24"]
    location            = "centralindia"
  }
}

subnet_final = {
  subnet = {
    name                 = "subnet-prod"
    resource_group_name  = "rg-prod"
    address_prefixes     = ["10.1.0.0/26"]
    virtual_network_name = "vnet-prod"
  }
}
