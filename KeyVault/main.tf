resource "azurerm_key_vault" "azkv" {
  # for_each                    = var.varkv
  name                        = "rohitkeyvault2"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set", "List"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "kvsecretuid" {
    for_each = var.varkv
  name         = "userid"
  value        = "azureadmin"
  key_vault_id = azurerm_key_vault.azkv.id
}

resource "azurerm_key_vault_secret" "kvsecretpwd" {
    for_each = var.varkv
  name         = "wowpasswordnew"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.azkv.id
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

