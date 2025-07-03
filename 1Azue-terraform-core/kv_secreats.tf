resource "azurerm_key_vault_secret" "Secr_sql" {
  content_type = "string"
  key_vault_id = azurerm_key_vault.kv.id
  name         = "sqladmin"
  value        = "sqladmin"
  depends_on = [
    azurerm_key_vault.kv,
  ]
}

resource "azurerm_key_vault_secret" "Secr_sqldbpwd" {
  content_type = "string"
  key_vault_id = azurerm_key_vault.kv.id
  name         = "sqldbpwd"
  value        = "enoviaV6"
  depends_on = [
    azurerm_key_vault.kv,
  ]
}
resource "azurerm_key_vault_secret" "Secr_sqlpwd" {
  content_type = "string"
  key_vault_id = azurerm_key_vault.kv.id
  name         = "sqlpwd"
  value        = "Technia#200*"
  depends_on = [
    azurerm_key_vault.kv,
  ]
}

resource "azurerm_key_vault_secret" "Secr_vmpwd" {
  content_type = "string"
  key_vault_id = azurerm_key_vault.kv.id
  name         = "vmpasswd"
  value        = "d^Fw[W#4#Pd-7Q/dR_#%$p7\\"
  depends_on = [
    azurerm_key_vault.kv,
  ]
}

resource "azurerm_key_vault_secret" "Secr_winadmin" {
  content_type = "string"
  key_vault_id = azurerm_key_vault.kv.id
  name         = "winadmin"
  value        = "adminuser"
  depends_on = [
    azurerm_key_vault.kv,
  ]
}