resource "azurerm_storage_account" "storage_australia" {
  account_replication_type = local.storage_account_replication_type
  account_tier             = local.storage_account_tier
  location                 = "${var.location1}"
  name                     = local.Storage1name
  resource_group_name      = local.rsgpcoreprefix
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

resource "azurerm_storage_container" "Con_install" {
  name                 = "install"
  storage_account_id = "${azurerm_storage_account.storage_australia.id}"
}


resource "azurerm_storage_share" "ffsharefiles" {
  name                 = "files"
  quota                = 1
  storage_account_id = "${azurerm_storage_account.storage_australia.id}"
}
