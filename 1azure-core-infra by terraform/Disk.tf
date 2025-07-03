resource "azurerm_managed_disk" "disk1_data" {
  create_option        = "Empty"
  location             = "${var.location}"
  name                 = "${local.resourceprefix}_datadisk"
  resource_group_name  = local.rsgpcoreprefix
  disk_size_gb         = "128"
  storage_account_type = "Premium_LRS"
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

resource "azurerm_managed_disk" "disk2_os" {
  create_option        = "Empty"
  location             = "${var.location}"
  name                 = "${local.resourceprefix}_osdisk"
  resource_group_name  = local.rsgpcoreprefix
  disk_size_gb         = "127"
  storage_account_type = "Premium_LRS"
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}