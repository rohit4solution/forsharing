data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  # for_each = var.varkv
  name     = "winvm1-rg"
}
