resource "azurerm_subnet" "snet" {
  for_each             = var.snet
  name                 = each.value.snetname
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.snetprefix
}