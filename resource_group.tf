resource "azurerm_resource_group" "this" {
  name     = "rg-librechat-${random_string.random_postfix.result}"
  location = var.location
}