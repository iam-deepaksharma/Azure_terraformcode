# resource "azurerm_resource_group" "rg" {
#   name     = "rg-sql-database"
#   location = "westus"
# }

# resource "azurerm_sql_server" "sql_server" {
#   name                         = "sqlserver12345" # Must be globally unique
#   resource_group_name          = azurerm_resource_group.rg.name
#   location                     = azurerm_resource_group.rg.location
#   version                      = "12.0"
#   administrator_login          = "adminuser"
#   administrator_login_password = "P@ssw0rd1234!"
# }

# resource "azurerm_sql_database" "sql_database" {
#   name                = "exampledb"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   server_name         = azurerm_sql_server.sql_server.name

#   sku_name = "Basic" # Cost-effective pricing tier for small workloads
# }

# resource "azurerm_sql_firewall_rule" "firewall" {
#   name                = "allow-all-azure-services"
#   resource_group_name = azurerm_resource_group.rg.name
#   server_name         = azurerm_sql_server.sql_server.name
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "0.0.0.0" # Allows all Azure services access
# }
