##############################################
# RBAC Resources
##############################################

/*
#aks administrators
data "azuread_group" "aks_administrators" {
  display_name      = "${local.rsgprefix}-cluster-administrators"
  description       = "Azure AKS Kubernetes administrators for the ${local.rsgprefix}-cluster."
  security_enabled  = true
}
*/

#user managed identity
data "azurerm_user_assigned_identity" "ag_umid" {
  name                = "${local.resourceprefix}-umid"
  resource_group_name = local.rsgpcoreprefix
}