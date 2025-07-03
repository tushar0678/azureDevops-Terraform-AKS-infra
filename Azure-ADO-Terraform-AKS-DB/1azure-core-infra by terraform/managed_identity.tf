/*
resource "azurerm_user_assigned_identity" "uid" {
  location            = "${var.location}"
  name                = "${local.resourceprefix}-umid"
  resource_group_name = local.rsgpcoreprefix
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}
*/