resource "azurerm_key_vault_key" "key_ssh" {
  key_opts     = ["sign", "verify", "wrapKey", "unwrapKey", "encrypt", "decrypt"]
  key_size     = 4096
  key_type     = "RSA"
  key_vault_id = azurerm_key_vault.kv.id
  name         = "sshkey"
  depends_on = [
    azurerm_key_vault.kv,
  ]
}