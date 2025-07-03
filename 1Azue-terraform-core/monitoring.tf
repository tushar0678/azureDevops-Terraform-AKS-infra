resource "azurerm_monitor_action_group" "az_mot" {
  name                = "RecommendedAlertRules-AG-1"
  resource_group_name = local.rsgpcoreprefix
  short_name          = "recalert1"
  email_receiver {
    email_address           = "claude.tsarafidy@technia.com"
    name                    = "Email_-EmailAction-"
    use_common_alert_schema = true
  }
  depends_on = [
    azurerm_resource_group.core_rg,
  ]
}