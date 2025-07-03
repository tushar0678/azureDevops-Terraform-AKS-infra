# build VMs Following standard Templates (managed disk)
# Image Type: taken from local.size_windows_vm
# OS: windows 2022
# managed disk - Premium LRS

#interface
resource "azurerm_network_interface" "appinterface" {
  name                = "${local.resourceprefix}vm-nic"
  location            = var.location
  resource_group_name = local.rsgprefix

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.aks-cluster.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    data.azurerm_subnet.aks-cluster, azurerm_resource_group.aks_rg
  ]
}

#network security group
resource "azurerm_network_security_group" "appnsg" {
  name                = "${local.rsgprefix}-NSG"
  location            = var.location
  resource_group_name = local.rsgprefix
  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}
#network security rules (RDP) - to allow Bastion to that VM
resource "azurerm_network_security_rule" "rdp" {
  name                        = "rdp"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.rsgprefix
  network_security_group_name = azurerm_network_security_group.appnsg.name

  depends_on = [
    azurerm_network_security_group.appnsg
  ]
}

#network security rules (RDP) - to allow Bastion to that VM
resource "azurerm_network_security_rule" "az" {
  name                        = "az"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.rsgprefix
  network_security_group_name = azurerm_network_security_group.appnsg.name

  depends_on = [
    azurerm_network_security_group.appnsg
  ]
}

#network security group association
resource "azurerm_subnet_network_security_group_association" "appnsglink" {
  subnet_id                 = data.azurerm_subnet.aks-cluster.id
  network_security_group_id = azurerm_network_security_group.appnsg.id
}

#machine definition
resource "azurerm_windows_virtual_machine" "adminvm" {
  name                = "${local.resourceprefix}vm" #add each for multiple VMs
  resource_group_name = local.rsgprefix
  location            = var.location
  size                = local.size_windows_vm
  admin_username      = data.azurerm_key_vault_secret.winadmin.value
  admin_password      = data.azurerm_key_vault_secret.vmpasswd.value
  network_interface_ids = [
    azurerm_network_interface.appinterface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.appinterface,
    azurerm_resource_group.aks_rg
  ]
}

