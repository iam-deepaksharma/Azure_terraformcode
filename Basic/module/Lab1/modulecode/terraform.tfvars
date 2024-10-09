sa_final = {
  sa1 = {
    name                     = "storageaccountname"
    resource_group_name      = "rg-module"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
}
rg_final = {
  rg1 = {
    name     = "rg-module"
    location = "centralindia"
  }
}
