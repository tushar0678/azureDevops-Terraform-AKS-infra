terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.99.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "rg1"
    storage_account_name = "nbvccvb"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }

}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    }
  }
}

#Resouce group creation
resource "azurerm_resource_group" "core_rg" {
  name     = local.rsgpcoreprefix
  location = "${var.location}" 
}

