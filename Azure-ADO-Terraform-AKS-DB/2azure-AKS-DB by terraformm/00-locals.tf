# 0. locals
locals {

  ##Refactoring
  businessfunction      = "TS"
  service               = "AZ"
  application           = "aks"
  deployedloc           = var.location == "uksouth" ? "uks" : ""
  name                  = "${var.environment}-${local.deployedloc}-${local.application}"
  rsgprefix_lower       = "${var.environment}-${local.businessfunction}-${local.service}-${local.application}"
  sanitized_service     = lower(replace(local.service, "/[^A-Za-z0-9]/", ""))
  sanitized_application = lower(replace(local.application, "/[^A-Za-z0-9]/", ""))
  resourceprefix        = lower(replace(local.name, "/[^A-Za-z0-9]/", ""))
  rsgprefix             = upper(local.rsgprefix_lower)
  rsgpcoreprefix        = "${local.rsgprefix}-CORE"

  #Instances Size
  size_windows_vm      = "Standard_D8s_v3"
  size_node_systempool = "Standard_DS2_v2"
  size_node_3dx        = "Standard_D8s_v5"
  size_node_3ds        = "Standard_D16ds_v4"
  size_node_win        = "Standard_DS3_v2"
  storage_account_type = "Premium_LRS"

  #Network specifics
  core_vnet_name = "${local.rsgpcoreprefix}-Vnet"
  cluster_vnet   = "Server-network"

  #KUBERNETES Addons
  addons = {
    oms_agent                   = true
    ingress_application_gateway = true
    http_application_routing    = false
    azure_policy                = true
    keyvaultSecretProvider      = true
    enableSecretRotation        = false
  }

  #AG specifics
  frontend_ip_configuration_name = "${local.resourceprefix}ag-feip"
  redirect_configuration_name    = "${local.resourceprefix}ag-rdrcfg"
  backend_address_pool_name_app  = "${local.resourceprefix}ag-beap-app"
  http_setting_name_app          = "${local.resourceprefix}ag-be-htst-app"
  probe_name_app                 = "${local.resourceprefix}ag-be-probe-app"
  probe_path                     = "/server-status"
  probe_port                     = "80"
  app_path                       = "/proxy/"
  #FQDN                           = "URL for access services"


  # HTTP Listener -  Port 80
  listener_name_http             = "${local.resourceprefix}ag-lstn-http"
  request_routing_rule_name_http = "${local.resourceprefix}ag-rqrt-http"
  frontend_port_name_http        = "${local.resourceprefix}ag-feport-http"

  # HTTPS Listener -  Port 443
  listener_name_https             = "${local.resourceprefix}ag-lstn-https"
  request_routing_rule_name_https = "${local.resourceprefix}ag-rqrt-https"
  frontend_port_name_https        = "${local.resourceprefix}ag-feport-https"

  ## SSL Certificates
  ssl_certificate_name    = "${var.environment}${local.businessfunction}${local.service}"
  ag_managedidentity_type = "UserAssigned"
  ag_subnet_range         = ["10.1.3.0/24"]
  ag_private_ip           = "10.1.3.254"
  ag_inbound_ports_map = {
    "100" : "80",
    "110" : "443",
    "130" : "65200-65535"
  }
}