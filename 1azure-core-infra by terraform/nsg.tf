resource "azurerm_network_security_group" "nsg1" {
  location            = var.location
  name                = "${local.resourceprefix}-AG-NSG"
  resource_group_name = local.rsgpcoreprefix
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

resource "azurerm_network_security_group" "nsg2" {
  location            = var.location
  name                = "${local.resourceprefix}-NSG"
  resource_group_name = local.rsgpcoreprefix
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}



resource "azurerm_network_security_rule" "nsgrule2" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "Rule-Port-443"
  network_security_group_name = "${local.resourceprefix}-AG-NSG"
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = local.rsgpcoreprefix
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.nsg1,
  ]
}
resource "azurerm_network_security_rule" "nsgrule1" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "8182"
  direction                   = "Inbound"
  name                        = "AllowAnyCustom8182Inbound"
  network_security_group_name = "${local.resourceprefix}-AG-NSG"
  priority                    = 140
  protocol                    = "*"
  resource_group_name         = local.rsgpcoreprefix
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.nsg1,
  ]
}


resource "azurerm_network_security_rule" "nsgrule3" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "Rule-Port-80"
  network_security_group_name = "${local.resourceprefix}-AG-NSG"
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = local.rsgpcoreprefix
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.nsg1,
  ]
}

resource "azurerm_network_security_rule" "nsgrule4" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "65200-65535"
  direction                   = "Inbound"
  name                        = "Rule-Port-65200-65535"
  network_security_group_name = "${local.resourceprefix}-AG-NSG"
  priority                    = 130
  protocol                    = "Tcp"
  resource_group_name         = local.rsgpcoreprefix
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.nsg1,
  ]
}
resource "azurerm_network_security_rule" "nsgrulee1" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "rdp"
  network_security_group_name = "${local.resourceprefix}-NSG"
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = local.rsgpcoreprefix
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.nsg2,
  ]
}


resource "azurerm_network_security_rule" "nsgrulee2" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "65200-65535"
  direction                   = "Inbound"
  name                        = "az"
  network_security_group_name = "${local.resourceprefix}-NSG"
  priority                    = 130
  protocol                    = "Tcp"
  resource_group_name         = local.rsgpcoreprefix
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.nsg2,
  ]
}


