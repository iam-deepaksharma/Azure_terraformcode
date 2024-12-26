# # Set the required provider
# provider "azurerm" {
#   features {}
# }

# # Resource group
# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "East US"
# }

# # Virtual network
# resource "azurerm_virtual_network" "example" {
#   name                = "example-vnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

# # Subnet
# resource "azurerm_subnet" "example" {
#   name                 = "example-subnet"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# # Public IP for Load Balancer
# resource "azurerm_public_ip" "load_balancer" {
#   name                = "example-lb-public-ip"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   allocation_method   = "Static"
# }

# # Load Balancer
# resource "azurerm_lb" "example" {
#   name                = "example-load-balancer"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   frontend_ip_configuration {
#     name                 = "example-frontend"
#     public_ip_address_id = azurerm_public_ip.load_balancer.id
#   }
# }

# # Backend Address Pool for Load Balancer
# resource "azurerm_lb_backend_address_pool" "example" {
#   name                = "example-backend-pool"
#   resource_group_name = azurerm_resource_group.example.name
#   loadbalancer_id     = azurerm_lb.example.id
# }

# # Load Balancer Probe
# resource "azurerm_lb_probe" "example" {
#   name                = "example-health-probe"
#   resource_group_name = azurerm_resource_group.example.name
#   loadbalancer_id     = azurerm_lb.example.id
#   protocol            = "Tcp"
#   port                = 22 # Health probe for SSH (can be HTTP or other protocols)
# }

# # Load Balancer Rule
# resource "azurerm_lb_rule" "example" {
#   name                           = "example-lb-rule"
#   resource_group_name            = azurerm_resource_group.example.name
#   loadbalancer_id                = azurerm_lb.example.id
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   frontend_ip_configuration_name = "example-frontend"
#   backend_address_pool_id        = azurerm_lb_backend_address_pool.example.id
#   probe_id                       = azurerm_lb_probe.example.id
# }

# # Network Interface with Load Balancer Backend Pool
# resource "azurerm_network_interface" "example" {
#   name                = "example-nic"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   ip_configuration {
#     name                          = "example-ip-config"
#     subnet_id                     = azurerm_subnet.example.id
#     private_ip_address_allocation = "Dynamic"
#     load_balancer_backend_address_pool_ids = [
#       azurerm_lb_backend_address_pool.example.id,
#     ]
#   }
# }

# # Linux virtual machine
# resource "azurerm_linux_virtual_machine" "example" {
#   name                = "example-vm"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   size                = "Standard_B1s"

#   admin_username = "adminuser"
#   admin_password = "P@ssw0rd123!" # Replace with a secure password

#   network_interface_ids = [
#     azurerm_network_interface.example.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
# }

# # Output the Load Balancer's Public IP
# output "load_balancer_public_ip" {
#   value = azurerm_public_ip.load_balancer.ip_address
# }
