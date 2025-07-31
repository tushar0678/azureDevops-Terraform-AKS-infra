terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }

/*   backend "azurerm" {
    resource_group_name = "rg1"
    storage_account_name = "teraform"
    container_name = "tfstate"
    key = "terraform.tfstate"
  } */

}
/* # Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    } 
   
  }
} */


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    } 
  }
  # Add your Azure Subscription ID here
  subscription_id = "86ce4adb-42b6-4dc3-a9b1-a319bf60cf54"
}

#Resouce group creation
resource "azurerm_resource_group" "core_rg" {
  name     = local.rsgpcoreprefix
  location = "${var.location}" 
}

