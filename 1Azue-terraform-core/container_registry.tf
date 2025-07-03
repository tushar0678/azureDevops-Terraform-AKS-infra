resource "azurerm_container_registry" "acr" {
  admin_enabled       = true
  location            = "${var.location}"
  name                = "${local.resourceprefix}acr"
  resource_group_name = local.rsgpcoreprefix
  sku                 = local.acr_sku
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}

#resource "azurerm_container_registry_scope_map" "acr-sm-admin" {
#  actions                 = ["repositories/*/metadata/read", "repositories/*/metadata/write", "repositories/*/content/read", "repositories/*/content/write", "repositories/*/content/delete"]
#  container_registry_name = "${azurerm_container_registry.acr.name}"
#  description             = "Can perform all read, write and delete operations on the registry"
#  name                    = local.acr_scope_map_admin
#  resource_group_name     = local.rsgpcoreprefix
#  depends_on = [
#    azurerm_container_registry.acr,
#  ]
#}

#resource "azurerm_container_registry_scope_map" "acr-sm-pull" {
#  actions                 = ["repositories/*/content/read"]
#  container_registry_name = "${azurerm_container_registry.acr.name}"
#  description             = "Can pull any repository of the registry"
#  name                    = local.acr_scope_map_pull
#  resource_group_name     = local.rsgpcoreprefix
#  depends_on = [
#    azurerm_container_registry.acr,
#  ]
#}


#resource "azurerm_container_registry_scope_map" "acr-sm-push" {
#  actions                 = ["repositories/*/content/read", "repositories/*/content/write"]
#  container_registry_name = "${azurerm_container_registry.acr.name}"
#  description             = "Can push to any repository of the registry"
#  name                    = local.acr_scope_map_push
#  resource_group_name     = local.rsgpcoreprefix
#  depends_on = [
#    azurerm_container_registry.acr,
# ]
#}


