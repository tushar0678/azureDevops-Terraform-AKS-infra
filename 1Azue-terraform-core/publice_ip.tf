#Public IP

resource "azurerm_public_ip" "az_pip" {
  allocation_method   = local.pip_allocation_method
  location            = "${var.location}"
  name                = "${local.rsgpcoreprefix}-PIP"
  resource_group_name = local.rsgpcoreprefix
  sku                 = local.pip_sku
  zones               = local.pip_zones
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}