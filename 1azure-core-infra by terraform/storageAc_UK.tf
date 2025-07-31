resource "azurerm_storage_account" "storage_uk" {
  account_replication_type = local.storage_account_replication_type
  account_tier             = local.storage_account_tier
  location                 = "${var.location}"
  name                     = "${local.resourceprefix}files"
  resource_group_name      = local.rsgpcoreprefix
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

resource "azurerm_storage_container" "databases" {
  name                 = "databases"
  storage_account_id = "${azurerm_storage_account.storage_uk.id}"
}
resource "azurerm_storage_container" "blob" {
  container_access_type = "blob"
  name                  = "test"
  storage_account_id  = "${azurerm_storage_account.storage_uk.id}"
}

resource "azurerm_storage_container" "tfstatefiles" {
  name                 = "tfstatefiles"
  storage_account_id = "${azurerm_storage_account.storage_uk.id}"
}
resource "azurerm_storage_container" "dbs" {
  name                 = "dbs"
  storage_account_id = "${azurerm_storage_account.storage_uk.id}"
}
resource "azurerm_storage_share" "files1" {
  name                 = "files"
  quota                = 5 #GB
  storage_account_id = "${azurerm_storage_account.storage_uk.id}"
}

resource "azurerm_storage_share" "webapp" {
  name                 = "webapp"
  quota                = 1
  storage_account_id = "${azurerm_storage_account.storage_uk.id}"
}
