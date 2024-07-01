resource "azurerm_resource_group" "dhondhurg" {
  for_each = var.vnets
#   {
#     rg1 = {
#       name     = "dhondhu-rg"
#       location = "westeurope"
#     }
  
  name     = each.value.rg_name
  location = each.value.location
}

# Nested Loops
resource "azurerm_virtual_network" "dhondhuvnet" {
  for_each            = var.vnets
  name                = each.value.vnetName
  location            = azurerm_resource_group.dhondhurg[each.key].location
  resource_group_name = azurerm_resource_group.dhondhurg[each.key].name
  address_space       = each.value.address_space

  dynamic "subnet" {
    for_each = each.value.g13subnet
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }
}

resource "azurerm_virtual_network_peering" "dhondhuvnet" {
    for_each = var.vnets
  name                      = "vnet1toVnet2"
  resource_group_name       = azurerm_resource_group.dhondhurg["vnet1"].name
  virtual_network_name      = azurerm_virtual_network.dhondhuvnet["vnet1"].name
  remote_virtual_network_id = azurerm_virtual_network.dhondhuvnet["vnet2"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "example-2" {
    for_each =var.vnets
  name                      = "vnet2toVnet1"
  resource_group_name       = azurerm_resource_group.dhondhurg["vnet2"].name
  virtual_network_name      = azurerm_virtual_network.dhondhuvnet["vnet2"].name
  remote_virtual_network_id = azurerm_virtual_network.dhondhuvnet["vnet1"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}