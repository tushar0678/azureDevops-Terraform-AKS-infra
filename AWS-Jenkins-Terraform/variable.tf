variable "region" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "key_name" {}
variable "eks_cluster_name" {}
variable "eks_node_group_instance_type" {}

variable "domain_name" {}
variable "alb_dns_name" {}
variable "alb_zone_id" {}
variable "alb_arn" {}

variable "tfstate_bucket_name" {}
variable "tfstate_lock_table" {}
variable "secret_id_for_backend" {}



