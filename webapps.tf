resource "azurerm_service_plan" "librechat" {
  name                = "librechat-asp${random_string.random_postfix.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"

  sku_name = var.app_service_sku_name
}

resource "azurerm_linux_web_app" "librechat" {
  name                          = "librechatapp${random_string.random_postfix.result}"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  service_plan_id               = azurerm_service_plan.librechat.id
  public_network_access_enabled = true
  https_only                    = true

  site_config {
    minimum_tls_version = "1.2"

  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
    application_logs {
      file_system_level = "Information"
    }
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
    HOST                     = "0.0.0.0"
    MONGO_URI                = azurerm_cosmosdb_account.librechat.connection_strings[0]
    # MONGO_URI                = var.mongo_uri
    OPENAI_API_KEY     = var.openai_key
    MEILI_MASTER_KEY   = random_string.meilisearch_master_key.result
    MEILI_HOST         = "${azurerm_linux_web_app.meilisearch.name}.azurewebsites.net"
    SEARCH             = true
    MEILI_NO_ANALYTICS = true

    APP_TITLE = var.app_title

    AZURE_API_KEY                                = module.openai.openai_primary_key
    AZURE_OPENAI_API_INSTANCE_NAME               = split("//", split(".", module.openai.openai_endpoint)[0])[1]
    AZURE_OPENAI_API_DEPLOYMENT_NAME             = "gpt-35-turbo"
    AZURE_OPENAI_API_VERSION                     = "2023-05-15"
    AZURE_OPENAI_API_COMPLETIONS_DEPLOYMENT_NAME = "gpt-35-turbo"
    AZURE_OPENAI_API_EMBEDDINGS_DEPLOYMENT_NAME  = "text-embedding-ada-002"

    CHATGPT_TOKEN  = var.chatgpt_token
    CHATGPT_MODELS = "text-davinci-002-render-sha,gpt-4"

    ANTHROPIC_API_KEY = var.anthropic_api_key
    ANTHROPIC_MODELS  = "claude-1,claude-instant-1,claude-2"

    BINGAI_TOKEN = var.bingai_token

    GOOGLE_API_KEY = ""
    GOOGLE_CSE_ID  = ""

    PALM_KEY = var.palm_key

    PLUGIN_MODELS = "gpt-3.5-turbo,gpt-3.5-turbo-16k,gpt-3.5-turbo-0301,gpt-4,gpt-4-0314,gpt-4-0613"


    CREDS_KEY = random_string.creds_key.result
    CREDS_IV  = random_string.creds_iv.result

    JWT_SECRET    = random_string.jwt_secret.result
    DOMAIN_SERVER = "http://localhost:3080"
    DOMAIN_CLIENT = "http://localhost:3080"

    VITE_SHOW_GOOGLE_LOGIN_OPTION = false
    ALLOW_REGISTRATION            = true

    SESSION_EXPIRY = (1000 * 60 * 60 * 24) * 7

    DOCKER_REGISTRY_SERVER_URL          = "https://index.docker.io"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_ENABLE_CI                    = false
    WEBSITES_PORT                       = 80
    PORT                                = 80
    DOCKER_CUSTOM_IMAGE_NAME            = "ghcr.io/danny-avila/librechat-dev-api:latest"
    NODE_ENV                            = "production"
  }
  virtual_network_subnet_id = azurerm_subnet.librechat_subnet.id

  depends_on = [azurerm_linux_web_app.meilisearch, azurerm_cosmosdb_account.librechat, module.openai]
  # depends_on = [azurerm_linux_web_app.meilisearch]
}

#  Deploy code from a public GitHub repo
# resource "azurerm_app_service_source_control" "sourcecontrol" {
#   app_id                 = azurerm_linux_web_app.librechat.id
#   repo_url               = "https://github.com/danny-avila/LibreChat"
#   branch                 = "main"    
#   type = "Github"

#   # use_manual_integration = true
#   # use_mercurial          = false
#   depends_on = [
#     azurerm_linux_web_app.librechat,
#   ]
# }

# resource "azurerm_app_service_virtual_network_swift_connection" "librechat" {
#   app_service_id = azurerm_linux_web_app.librechat.id
#   subnet_id      = module.vnet.vnet_subnets_name_id["subnet0"]

#   depends_on = [
#     azurerm_linux_web_app.librechat,
#     module.vnet
#   ]
# }

#TODO: privately communicate between librechat and meilisearch, right now it is via public internet
resource "azurerm_linux_web_app" "meilisearch" {
  name                = "meilisearchapp${random_string.random_postfix.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.librechat.id

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    MEILI_MASTER_KEY   = random_string.meilisearch_master_key.result
    MEILI_NO_ANALYTICS = true

    DOCKER_REGISTRY_SERVER_URL          = "https://index.docker.io"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_ENABLE_CI                    = false
    WEBSITES_PORT                       = 7700
    PORT                                = 7700
    DOCKER_CUSTOM_IMAGE_NAME            = "getmeili/meilisearch:latest"
  }

  site_config {
    always_on = "true"
    ip_restriction {
      virtual_network_subnet_id = azurerm_subnet.librechat_subnet.id
      priority                  = 100
      name                      = "Allow from LibreChat subnet"
      action                    = "Allow"
    }
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
    application_logs {
      file_system_level = "Information"
    }
  }

  # identity {
  #   type = "SystemAssigned"
  # }

}
