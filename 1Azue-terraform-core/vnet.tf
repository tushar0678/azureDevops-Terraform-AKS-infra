resource "azurerm_virtual_network" "core_vnet" {
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  name                = local.core_vnet_name
  resource_group_name = local.rsgpcoreprefix
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  address_prefixes     = ["10.1.10.0/24"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = local.rsgpcoreprefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  virtual_network_name = "${local.rsgpcoreprefix}-Vnet"
  depends_on = [
    azurerm_virtual_network.core_vnet,
  ]
}

resource "azurerm_subnet" "GatewaySubnet" {
  address_prefixes     = ["10.1.1.0/24"]
  name                 = "GatewaySubnet"
  resource_group_name  = local.rsgpcoreprefix
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
  virtual_network_name = "${local.rsgpcoreprefix}-Vnet"
  depends_on = [
    azurerm_virtual_network.core_vnet,
  ]
}

resource "azurerm_subnet" "Server_network" {
  address_prefixes     = ["10.1.2.0/24"]
  name                 = "Server-network"
  resource_group_name  = local.rsgpcoreprefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage"]
  virtual_network_name = "${local.rsgpcoreprefix}-Vnet"
  depends_on = [
    azurerm_virtual_network.core_vnet,
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg_ass1" {
  #network_security_group_id = "/subscriptions/94ac3d39-f824-412c-9dde-79f727f64dc8/resourceGroups/DEV-GS-PLM-AKS/providers/Microsoft.Network/networkSecurityGroups/DEV-GS-PLM-AKS-NSG"
  #subnet_id                 = "/subscriptions/94ac3d39-f824-412c-9dde-79f727f64dc8/resourceGroups/${local.rsgpcoreprefix}/providers/Microsoft.Network/virtualNetworks/${local.rsgpcoreprefix}-Vnet/subnets/Server-network"
  network_security_group_id = "${azurerm_network_security_group.nsg2.id}"
  subnet_id                 = "${azurerm_subnet.Server_network.id}"
  depends_on = [
    azurerm_subnet.Server_network,
  ]
}

resource "azurerm_subnet" "defaultt" {
  address_prefixes     = ["10.1.0.0/24"]
  name                 = "default"
  resource_group_name  = local.rsgpcoreprefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql"]
  virtual_network_name = "${local.rsgpcoreprefix}-Vnet"
  depends_on = [
    azurerm_virtual_network.core_vnet,
  ]
}

resource "azurerm_subnet" "akssubnet" {
  address_prefixes     = ["10.1.3.0/24"]
  name                 = "devuksaksagsubnet"
  resource_group_name  = local.rsgpcoreprefix
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Web"]
  virtual_network_name = "${local.rsgpcoreprefix}-Vnet"
  depends_on = [
    azurerm_virtual_network.core_vnet,
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg_akssubnet" {
  #network_security_group_id = "/subscriptions/94ac3d39-f824-412c-9dde-79f727f64dc8/resourceGroups/DEV-GS-PLM-AKS/providers/Microsoft.Network/networkSecurityGroups/DEV-GS-PLM-AKS-AG-NSG"
  #subnet_id                 = "/subscriptions/94ac3d39-f824-412c-9dde-79f727f64dc8/resourceGroups/${local.rsgpcoreprefix}/providers/Microsoft.Network/virtualNetworks/${local.rsgpcoreprefix}-Vnet/subnets/devuksaksagsubnet"
  network_security_group_id  = "${azurerm_network_security_group.nsg1.id}"
  subnet_id                 = "${azurerm_subnet.akssubnet.id}"
  depends_on = [
    azurerm_subnet.akssubnet,
  ]
}


