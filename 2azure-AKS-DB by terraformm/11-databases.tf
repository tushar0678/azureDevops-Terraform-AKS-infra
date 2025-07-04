/* Provision databases and related resources
  SQL Server
  3DExperience Databases
*/

resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_mssql_server" "sqlserver" {
  name                = lower("${local.resourceprefix}-MI-SQL")
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = var.location
  version             = "12.0"
  # move the admin name to keyvault?
  administrator_login          = data.azurerm_key_vault_secret.sqladmin.value
  administrator_login_password = data.azurerm_key_vault_secret.sqlpwd.value

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

resource "azurerm_mssql_firewall_rule" "allowAzureServices" {
  name             = "Allow_Azure_Services"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  depends_on = [
    azurerm_mssql_server.sqlserver
  ]

}

resource "azurerm_mssql_virtual_network_rule" "mssql-cluster-subnet-vnet-cluster-rule" {
  name      = "mssql-cluster-subnet-vnet-cluster-rule"
  server_id = azurerm_mssql_server.sqlserver.id
  subnet_id = data.azurerm_subnet.aks-cluster.id

  depends_on = [
    azurerm_mssql_server.sqlserver
  ]

}