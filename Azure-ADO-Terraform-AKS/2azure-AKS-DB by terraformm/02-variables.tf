variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
}

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
}

/*
variable "tags" {
  type        = map(any)
  description = "Specifies a map of tags to be applied to the resources created."
}
*/