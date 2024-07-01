resource "azurerm_virtual_network" "VNET" {
  for_each            = var.vnet
  name                = "${each.value.vname}-vnet"
  address_space       = each.value.adds
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
}

# resource "azurerm_subnet" "SNET" {
#     depends_on = [ azurerm_virtual_network.VNET ]
#   for_each             = var.vnet
#   name                 = each.value.sname
#   resource_group_name  = data.azurerm_resource_group.rg[each.key].name
#   virtual_network_name = each.value.vname
#   address_prefixes     = each.value.snetadd
# }
