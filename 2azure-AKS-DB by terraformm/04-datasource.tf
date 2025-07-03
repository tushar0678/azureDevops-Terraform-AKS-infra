##############################################
# KUBERNETES
##############################################
# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}

# Datasource to get the client configuration
data "azuread_client_config" "current" {}

##############################################
# CORE RESOURCES - Locked against Delete
##############################################

# Datasource - core - resource group
data "azurerm_resource_group" "core" {
  name = local.rsgpcoreprefix
}

# Datasource - core - Storage Account
data "azurerm_storage_account" "core" {
  name                = "${local.resourceprefix}files"
  resource_group_name = local.rsgpcoreprefix
}

# Datasource - core - KeyVault & secrets / keys
data "azurerm_key_vault" "keyvault" {
  name                = "${local.resourceprefix}keys"
  resource_group_name = local.rsgpcoreprefix
}

data "azurerm_key_vault_secret" "vmpasswd" {
  name         = "vmpasswd"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "winadmin" {
  name         = "winadmin"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "sqladmin" {
  name         = "sqladmin"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "sqlpwd" {
  name         = "sqlpwd"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "sqldbpwd" {
  name         = "sqldbpwd"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_key" "sshkey" {
  name         = "sshkey" # #refactor
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_certificate" "ssl_certs" {
  name         = local.ssl_certificate_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

##############################################
# CORE NETWORK RESOURCES - Locked against Delete
##############################################

data "azurerm_virtual_network" "aksvnet" {
  name                = local.core_vnet_name
  resource_group_name = local.rsgpcoreprefix
}

data "azurerm_subnet" "aks-cluster" {
  name                 = local.cluster_vnet
  resource_group_name  = local.rsgpcoreprefix
  virtual_network_name = local.core_vnet_name
}

data "azurerm_container_registry" "acr" {
  name                = "${local.resourceprefix}acr"
  resource_group_name = local.rsgpcoreprefix
}
