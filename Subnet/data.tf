data "azurerm_resource_group" "rg" {

#   for_each = var.snet
  name     = "winvm1-rg"

}

data "azurerm_virtual_network" "vnet" {
  name                = "winvm1-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
}