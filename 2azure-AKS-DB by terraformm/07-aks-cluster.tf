# Provision AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${local.rsgprefix}-AKSC"
  location            = var.location
  resource_group_name = local.rsgprefix
  dns_prefix          = "${local.rsgprefix}-AKSC"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${local.rsgprefix}-NRG"

  default_node_pool {
    name                 = "systempool"
    vm_size              = local.size_node_systempool
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    availability_zones   = [1, 2, 3]
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id       = data.azurerm_subnet.aks-cluster.id
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = var.environment
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = {
      "nodepool-type" = "system"
      "environment"   = var.environment
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
  }

  # Add On Profiles
  addon_profile {
    azure_policy {
      enabled = local.addons.azure_policy
    }
    http_application_routing {
      enabled = local.addons.http_application_routing
    }
    oms_agent {
      enabled                    = local.addons.oms_agent
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }
    ingress_application_gateway {
      enabled   = local.addons.ingress_application_gateway
      gateway_id = azurerm_application_gateway.web_ag.id
    }
    azure_keyvault_secrets_provider {
      enabled = local.addons.keyvaultSecretProvider
    }

  }

  role_based_access_control {
    enabled = true
    /*
    azure_active_directory {
      managed = true
      admin_group_object_ids = [data.azuread_group.aks_administrators.id]
    }
    */
  }

  # Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

  /*
  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }
  */

  # Windows Profile
  windows_profile {
    admin_username = data.azurerm_key_vault_secret.winadmin.value
    admin_password = data.azurerm_key_vault_secret.vmpasswd.value
  }

  # Linux Profile
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = data.azurerm_key_vault_key.sshkey.public_key_openssh
    }
  }

  # Network Profile
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "Standard"
    #docker_bridge_cidr = var.aks_docker_bridge_cidr
    #service_cidr       = var.aks_service_cidr
  }

  tags = {
    Environment = var.environment
  }

  depends_on = [
    azurerm_resource_group.aks_rg, azurerm_application_gateway.web_ag 
  ]

}

/*
resource "azurerm_role_assignment" "aks_to_acr_role" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
}
*/