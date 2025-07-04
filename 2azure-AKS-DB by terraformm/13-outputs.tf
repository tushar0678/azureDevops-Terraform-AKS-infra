# Create Outputs
# 1. Resource Group Location
# 2. Resource Group Id
# 3. Resource Group Name
# 4. Azure AKS Versions Datasource
# 5. Azure AD Group Object Id
# 6. Azure AKS Outputs
# 7. Azure SQL Outputs

# Resource Group Outputs

output "location" {
  value = var.location
}

output "deployedloc" {
  value = local.deployedloc
}

# Resource Group Outputs
output "name" {
  value = local.name
}

# Resource Group Outputs
output "rsgprefix_lower" {
  value = local.rsgprefix_lower
}

# Resource Group Outputs
output "sanitized_service" {
  value = local.sanitized_service
}

# Resource Group Outputs
output "resourceprefix" {
  value = local.resourceprefix
}

# Resource Group Outputs
output "rsgprefix" {
  value = local.rsgprefix
}

output "resource_group_id" {
  value = azurerm_resource_group.aks_rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.aks_rg.name
}

# Azure AKS Versions Datasource
output "versions" {
  value = data.azurerm_kubernetes_service_versions.current.versions
}

output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.current.latest_version
}

/*
# Azure AD Group Object Id
output "azure_ad_group_id" {
  value = data.azuread_group.aks_administrators.id
}
output "azure_ad_group_objectid" {
  value = data.azuread_group.aks_administrators.object_id
}
*/

# Azure AKS Outputs
output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubernetes_version
}

# Azure SQL Outputs
output "mssql_fqdn" {
  description = "The FQDN of the sql server."
  value       = azurerm_mssql_server.sqlserver.fully_qualified_domain_name
  sensitive   = true
}