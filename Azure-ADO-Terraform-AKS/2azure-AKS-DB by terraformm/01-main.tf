# 1. Terraform Settings Block
# 2. Terraform Provider Block for AzureRM
# 3. Terraform Resource Block: Define a Random Pet Resource
# 4. Terraform Resource Block: Define mssql resource

# 1. Terraform Settings Block
terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      #version = "~> 2.15.0"
      version = "~> 1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      version = "~> 3.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    mssql = {
      source  = "betr-io/mssql"
      version = "0.2.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }
  }

  backend "azurerm" {
  }

}


# 2. Terraform Provider Block for AzureRM
provider "azurerm" {
  skip_provider_registration = "true"
  features {
  }
}

# 3. Terraform Resource Block: Define a Random Pet Resource
resource "random_pet" "aksrandom" {

}

# 4. Terraform Resource Block: Define mssql resource
provider "mssql" {
  # Configuration options
}

# 5. Kubernetes Provider
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)

  load_config_file = "false"
}

# 6. Helm Provider
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
    username               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
    password               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
    load_config_file       = "false"
  }
}

##############################################
# RESOURCES
##############################################
# Terraform Resource to Create Azure Resource Group with Input Variables defined in variables.tf
resource "azurerm_resource_group" "aks_rg" {
  name     = local.rsgprefix
  location = var.location
}