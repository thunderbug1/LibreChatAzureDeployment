module "openai" {
  # application_name = "openai_service_librechat"
  source              = "Azure/openai/azurerm"
  version             = "0.1.1"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  public_network_access_enabled = true
  # private_endpoint = {
  #   "pe_endpoint" = {
  #     private_dns_entry_enabled       = true
  #     dns_zone_virtual_network_link   = "dns_zone_link_openai"
  #     is_manual_connection            = false
  #     name                            = "openai_pe"
  #     private_service_connection_name = "openai_pe_connection"
  #     subnet_name                     = "subnet0"
  #     vnet_name                       = module.vnet.vnet_name
  #     vnet_rg_name                    = azurerm_resource_group.this.name
  #   }
  # }
  deployment = {
    "chat_model" = {
      name          = "gpt-35-turbo"
      model_format  = "OpenAI"
      model_name    = "gpt-35-turbo"
      model_version = "0301"
      scale_type    = "Standard"
    },
    "embedding_model" = {
      name          = "text-embedding-ada-002"
      model_format  = "OpenAI"
      model_name    = "text-embedding-ada-002"
      model_version = "2"
      scale_type    = "Standard"
    },
  }
  depends_on = [
    azurerm_resource_group.this,
    # module.vnet
  ]
}


# resource "azurerm_cognitive_account" "openai" {
#   name                          = "openai_service_librechat"
#   location                      = azurerm_resource_group.this.location
#   resource_group_name           = azurerm_resource_group.this.name
#   kind                          = "OpenAI"
# #   custom_subdomain_name         = var.custom_subdomain_name
#   sku_name                      = "S0"
#   public_network_access_enabled = var.public_network_access_enabled
# #   tags                          = var.tags

#   private_endpoint = {
#     "pe_endpoint" = {
#       private_dns_entry_enabled       = true
#       dns_zone_virtual_network_link   = "dns_zone_link_openai"
#       is_manual_connection            = false
#       name                            = "openai_pe"
#       private_service_connection_name = "openai_pe_connection"
#       subnet_name                     = "subnet0"
#       vnet_name                       = module.vnet.vnet_name
#       vnet_rg_name                    = azurerm_resource_group.this.name
#     }
#   }

# #   identity {
# #     type = "SystemAssigned"
# #   }

# #   lifecycle {
# #     ignore_changes = [
# #       tags
# #     ]
# #   }
# }

# resource "azurerm_cognitive_deployment" "deployment" {
#   for_each             = {for deployment in var.deployments: deployment.name => deployment}

#   name                 = each.key
#   cognitive_account_id = azurerm_cognitive_account.openai.id

#   model {
#     format  = "OpenAI"
#     name    = each.value.model.name
#     version = each.value.model.version
#   }

#   scale {
#     type = "Standard"
#   }
# }
