# Create Application Gateway Subnet
resource "azurerm_subnet" "agsubnet" {
  name                 = "${local.resourceprefix}agsubnet"
  resource_group_name  = local.rsgpcoreprefix
  virtual_network_name = local.core_vnet_name
  address_prefixes     = local.ag_subnet_range
  service_endpoints    = ["Microsoft.Sql", "Microsoft.KeyVault", "Microsoft.Web"]
}

# Create Network Security Group (NSG)
resource "azurerm_network_security_group" "ag_subnet_nsg" {
  name                = "${local.rsgprefix}-AG-NSG"
  location            = var.location
  resource_group_name = local.rsgprefix
  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

# Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "ag_subnet_nsg_associate" {
  depends_on                = [azurerm_network_security_rule.ag_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                 = azurerm_subnet.agsubnet.id
  network_security_group_id = azurerm_network_security_group.ag_subnet_nsg.id
}

# NSG Inbound Rule for Azure Application Gateway Subnets
resource "azurerm_network_security_rule" "ag_nsg_rule_inbound" {
  for_each                    = local.ag_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.rsgprefix
  network_security_group_name = azurerm_network_security_group.ag_subnet_nsg.name
  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

#Azure Application Gateway Public IP
resource "azurerm_public_ip" "AG_PIP" {
  name                = "${local.rsgprefix}-AG-PIP"
  resource_group_name = local.rsgprefix
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

#Azure Application Gateway - Standard
resource "azurerm_application_gateway" "web_ag" {
  name                = "${local.rsgprefix}-AG"
  resource_group_name = local.rsgprefix
  location            = var.location

  #Define properties
  sku {
    name = "WAF_v2"
    tier = "WAF_v2"
  }
  autoscale_configuration {
    min_capacity = 0
    max_capacity = 4
  }
  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.agsubnet.id
  }

  # FrontEnd
  enable_http2 = true
  frontend_port {
    name = local.frontend_port_name_http
    port = 80
  }
  frontend_port {
    name = local.frontend_port_name_https
    port = 443
  }
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.AG_PIP.id
    private_ip_address   = local.ag_private_ip
  }
  frontend_ip_configuration {
    name                          = "${local.frontend_ip_configuration_name}-private"
    subnet_id                     = azurerm_subnet.agsubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = local.ag_private_ip
  }

  # Backend
  backend_address_pool {
    name = local.backend_address_pool_name_app
    //update the configuration with the AKS systempool
  }
  backend_http_settings {
    name                  = local.http_setting_name_app
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    #path                  = local.app_path
    #probe_name            = local.probe_name_app
  }
  /*
  probe {
    name                = local.probe_name_app
    host                = "127.0.0.1" #set the backend aks pool
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    protocol            = "Http"
    port                = 80
    path                = local.probe_path
    match { # Optional
      #body              = "app"
      status_code = ["200"]
    }
  }
  */

  # HTTP Listener - Port 80
  http_listener {
    name                           = local.listener_name_http
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}-private"
    frontend_port_name             = local.frontend_port_name_http
    protocol                       = "Http"
  }
  # HTTP Routing Rule - HTTP to HTTPS Redirect
  request_routing_rule {
    name                        = local.request_routing_rule_name_http
    rule_type                   = "Basic"
    http_listener_name          = local.listener_name_http
    redirect_configuration_name = local.redirect_configuration_name
  }
  # Redirect Config for HTTP to HTTPS Redirect
  redirect_configuration {
    name                 = local.redirect_configuration_name
    redirect_type        = "Permanent"
    target_listener_name = local.listener_name_https
    include_path         = true
    include_query_string = true
  }

  ssl_certificate {
    name                = local.ssl_certificate_name
    key_vault_secret_id = data.azurerm_key_vault_certificate.ssl_certs.secret_id
  }

  identity {
    identity_ids = [data.azurerm_user_assigned_identity.ag_umid.id]
    type         = local.ag_managedidentity_type
  }

  # HTTPS Listener - Port 443
  http_listener {
    name                           = local.listener_name_https
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}-private"
    frontend_port_name             = local.frontend_port_name_https
    protocol                       = "Https"
    ssl_certificate_name           = local.ssl_certificate_name
  }

  # HTTPS Routing Rule - Port 443
  request_routing_rule {
    name                       = local.request_routing_rule_name_https
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name_https
    backend_address_pool_name  = local.backend_address_pool_name_app
    backend_http_settings_name = local.http_setting_name_app
  }

  depends_on = [
    azurerm_resource_group.aks_rg
  ]

}