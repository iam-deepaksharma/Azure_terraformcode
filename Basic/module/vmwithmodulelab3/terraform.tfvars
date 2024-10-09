vm_var = {
  vm1 = {
    resource_group_name  = "rg-demon"
    location             = "centralindia"
    virtual_network_name = "vnet-demon"
    subnet_name          = "subnet-demon"
    vm_name              = "vm-demon"
    nic_name             = "nic-demon"
    size                 = "Standard_F2"
  }
  vm2 = {
    resource_group_name  = "rg-demon1"
    location             = "centralindia"
    virtual_network_name = "vnet-demon"
    subnet_name          = "subnet-demon1"
    vm_name              = "vm-demon1"
    nic_name             = "nic-demon1"
    size                 = "Standard_F2"
  }
}
