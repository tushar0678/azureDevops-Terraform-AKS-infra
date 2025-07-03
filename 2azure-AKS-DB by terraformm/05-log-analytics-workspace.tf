# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "insights" {
  name                = "${local.rsgprefix}-LAWS"
  location            = var.location
  resource_group_name = local.rsgprefix
  retention_in_days   = 30
  #sku                = "PerGB2018" is the default if not defined
  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}