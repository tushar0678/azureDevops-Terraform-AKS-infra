resource "azurerm_snapshot" "snap1" {
  create_option       = "Copy"
  location            = "${var.location}"
  name                = "${azurerm_managed_disk.disk1_data.name}_template"
  resource_group_name = local.rsgpcoreprefix
  source_uri          = azurerm_managed_disk.disk1_data.id
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}


resource "azurerm_snapshot" "snap2" {
  create_option       = "Copy"
  location            = "${var.location}"
  name                = "${azurerm_managed_disk.disk2_os.name}_template"
  resource_group_name = local.rsgpcoreprefix
 source_uri          = azurerm_managed_disk.disk2_os.id
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

