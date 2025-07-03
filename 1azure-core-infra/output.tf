# Resource Group Outputs


output "resource_group_id" {
  value = azurerm_resource_group.core_rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.core_rg.name
}

output "location" {
  value = var.location
}


#Storage Account -1 Central Australia

output "devapacaksfile" {
  description = "Storage account for Central Australia"
  value       = azurerm_storage_account.storage_australia.name
}

output "Con_install" {
  description = "Container inside Storage1 - Australia Central"
  value       = azurerm_storage_container.Con_install.name
}

output "ffsharefiles" {
  description = "Azure File Share inside Storage1 - Australia Central"
  value       = azurerm_storage_share.ffsharefiles.name
}

#Storage Account -2 UK South


output "storage_uk" {
  description = "Storage account for UK South"
  value       = azurerm_storage_account.storage_uk.name
}

output "Con_database" {
  description = "Container inside Storage2 - UK South"
  value       = azurerm_storage_container.databases.name
}

output "Con_test" {
  description = "Container inside Storage2 - UK South"
  value       = azurerm_storage_container.blob.name
}

output "Con_tfstatefiles" {
  description = "Container inside Storage2 - UK South"
  value       = azurerm_storage_container.tfstatefiles.name
}

output "Con_dbs" {
  description = "Container inside Storage2 - UK South"
  value       = azurerm_storage_container.dbs.name
}

output "fshare_webapp" {
  description = "Azure File Share inside Storage2 - UK South"
  value       = azurerm_storage_share.webapp.name
}

output "fshare_file" {
  description = "Azure File Share inside Storage2 - UK South"
  value       = azurerm_storage_share.files1.name
}

#Publice ip
output "Public_IP" {
  description = "Azure Core RG public IP"
  value       = azurerm_public_ip.az_pip.name
}

# Azure keyvault 
output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  description = "Name of key vault created."
  value       = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.kv.vault_uri
}

# Azure ACR 
output "ACR_Name" {
  description = "The Name of the ACR in Core RG."
  value       = azurerm_container_registry.acr.name
}
/*
# Azure managed Identity 
output "UID_Name" {
  description = "The Name of the MID in Core RG"
  value       = azurerm_user_assigned_identity.uid.name
}
*/
# DATADISKs
output "DATADISK_Name" {
  description = "The Name of DATADISK in Core RG"
  value       = azurerm_managed_disk.disk1_data.name
}

# OSDISKs
output "OSDISK_Name" {
  description = "The Name of OSDISK in Core RG"
  value       = azurerm_managed_disk.disk2_os.name
}


# SnapShot of DATADISKs
output "SnapShot_DATADISK_Name" {
  description = "The Name of SnapShot of DATADISK in Core RG"
  value       = azurerm_snapshot.snap1.name
}

# SnapShot of OSDISKs
output "SnapShot_OSDISK_Name" {
  description = "The Name of SnapShot of OSDISK in Core RG"
  value       = azurerm_snapshot.snap2.name
}



#Vnet & Subnet
output "Vnet_Name" {
  description = "The Name of Vent in Core RG"
  value       = azurerm_virtual_network.core_vnet.name
}
output "Subnet1_Name" {
  description = "The Name of Subnet1 in Core RG"
  value       = azurerm_subnet.AzureBastionSubnet.name
}

output "Subnet2_Name" {
  description = "The Name of Subnet2 in Core RG"
  value       = azurerm_subnet.GatewaySubnet.name
}

output "Subnet3_Name" {
  description = "The Name of Subnet3 in Core RG"
  value       = azurerm_subnet.Server_network.name
}

output "Subnet4_Name" {
  description = "The Name of Subnet4 in Core RG"
  value       = azurerm_subnet.defaultt.name
}


#Alert Rule
output "Alert_Rule_Name" {
  description = "Azure Core RG Alert Rule Name"
  value       = azurerm_monitor_action_group.az_mot.name
}
output "Alert_Rule_Email" {
  description = "Azure Core RG Alert Rule Name"
  value       = azurerm_monitor_action_group.az_mot.email_receiver
}

