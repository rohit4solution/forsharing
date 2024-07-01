# data "azurerm_public_ip" "pip" {
#   name                = "winvm1-rg-pip"
#   resource_group_name = "winvm1-rg"
# }

data "azurerm_key_vault" "kv" {
  name                = "rohitkeyvault2"
  resource_group_name = "winvm1-rg"
}

data "azurerm_resource_group" "rg" {

  for_each = var.winvm
  name     = "${each.key}-rg"
  
}

data "azurerm_key_vault_secret" "kvu" {
  name         = "userid"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_virtual_network" "vnet1" {
  name                = "winvm1-vnet"
  resource_group_name = "winvm1-rg"
}

data "azurerm_key_vault_secret" "kvp" {
  name         = "wowpasswordnew"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_subnet" "snetdata" {
  for_each = var.winvm
  name                 = each.value.snetname
  virtual_network_name = data.azurerm_virtual_network.vnet1.name
  resource_group_name  = "winvm1-rg"
}