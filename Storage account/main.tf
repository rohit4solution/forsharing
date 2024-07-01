resource "azurerm_resource_group" "ss" {
  for_each = var.sa
  name     = each.value.rgn
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  for_each                 = var.sa
  name                     = each.value.san
  resource_group_name      = azurerm_resource_group.ss[each.key].name
  location                 = azurerm_resource_group.ss[each.key].location
  account_tier             = each.value.act
  account_replication_type = each.value.art

  tags = {
    environment = "staging"
  }
}