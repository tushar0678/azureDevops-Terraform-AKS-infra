
# Azure Location
variable "location" {
  type = string
  description = "Azure Region where all these resources will be provisioned"
  
}

variable "environment" {
  type        = string
  description = "Describe the type of Environment"
  
}

variable "location1" {
  type = string
  description = "Azure Region where where Storage1 devapacaksfile will deploy"
}


/*
#pass variable in the form of list
variable "location_list_demo" {
  type = list
 }

 */