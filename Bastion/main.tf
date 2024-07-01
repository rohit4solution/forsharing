# resource "azurerm_virtual_network" "vnet" {
#   for_each            = var.varbas
#   name                = data.azurerm_virtual_network.vnet[each.key].name
#   address_space       = data.azurerm_virtual_network.vnet[each.key].address_space
#   location            = data.azurerm_resource_group.rg[each.key].location
#   resource_group_name = data.azurerm_resource_group.rg[each.key].name
# }

# value = [for vm in azurerm_windows_virtual_machine.winvm : vm.public_ip_address]

resource "azurerm_subnet" "bassnet" {
  for_each             = var.varbas
  name                 = "AzureBastionSubnet"
  resource_group_name  = data.azurerm_resource_group.rg[each.key].name
  virtual_network_name = data.azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = each.value.bas_address_space
}

resource "azurerm_public_ip" "baspip" {
  for_each            = var.varbas
  name                = "baspip"
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_bastion_host" "bastionconfig" {
  for_each            = var.varbas
  name                = each.value.bastion_name
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bassnet[each.key].id
    public_ip_address_id = azurerm_public_ip.baspip[each.key].id
  }
}