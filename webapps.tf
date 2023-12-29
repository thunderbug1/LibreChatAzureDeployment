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
    #==================================================#
    #               Server Configuration               #
    #==================================================#

    APP_TITLE = var.app_title
    # CUSTOM_FOOTER="My custom footer"
    HOST = "0.0.0.0"
    PORT = 80

    MONGO_URI = azurerm_cosmosdb_account.librechat.connection_strings[0]

    DOMAIN_CLIENT = "http://localhost:3080"
    DOMAIN_SERVER = "http://localhost:3080"

    #===============#
    # Debug Logging #
    #===============#
    DEBUG_LOGGING = true
    DEBUG_CONSOLE = false

    #=============#
    # Permissions #
    #=============#

    # UID=1000
    # GID=1000

    #===================================================#
    #                     Endpoints                     #
    #===================================================#

    ENDPOINTS = "azureOpenAI" #openAI,azureOpenAI,bingAI,chatGPTBrowser,google,gptPlugins,anthropic

    # PROXY=

    #============#
    # Anthropic  #
    #============#

    # ANTHROPIC_API_KEY = "user_provided"
    # ANTHROPIC_MODELS  = "claude-1,claude-instant-1,claude-2"
    # ANTHROPIC_REVERSE_PROXY=

    #============#
    # Azure      #
    #============#

    AZURE_API_KEY       = module.openai.openai_primary_key
    AZURE_OPENAI_MODELS = "gpt-3.5-turbo,gpt-4"
    # AZURE_OPENAI_DEFAULT_MODEL = "gpt-3.5-turbo"
    # PLUGINS_USE_AZURE = true

    AZURE_USE_MODEL_AS_DEPLOYMENT_NAME = true

    AZURE_OPENAI_API_INSTANCE_NAME = split("//", split(".", module.openai.openai_endpoint)[0])[1]
    # AZURE_OPENAI_API_DEPLOYMENT_NAME =
    AZURE_OPENAI_API_VERSION = var.azure_openai_api_version
    # AZURE_OPENAI_API_COMPLETIONS_DEPLOYMENT_NAME =
    # AZURE_OPENAI_API_EMBEDDINGS_DEPLOYMENT_NAME  =

    #============#
    # BingAI     #
    #============#

    BINGAI_TOKEN = var.bingai_token
    # BINGAI_HOST  = "https://cn.bing.com"

    #============#
    # ChatGPT    #
    #============#

    CHATGPT_TOKEN  = var.chatgpt_token
    CHATGPT_MODELS = "text-davinci-002-render-sha"
    # CHATGPT_REVERSE_PROXY = "<YOUR REVERSE PROXY>"

    #============#
    # Google     #
    #============#

    GOOGLE_KEY = "user_provided"
    # GOOGLE_MODELS="gemini-pro,gemini-pro-vision,chat-bison,chat-bison-32k,codechat-bison,codechat-bison-32k,text-bison,text-bison-32k,text-unicorn,code-gecko,code-bison,code-bison-32k"
    # GOOGLE_REVERSE_PROXY= "<YOUR REVERSE PROXY>"

    #============#
    # OpenAI     #
    #============#

    # OPENAI_API_KEY = var.openai_key
    # OPENAI_MODELS = "gpt-3.5-turbo-1106,gpt-4-1106-preview,gpt-3.5-turbo,gpt-3.5-turbo-16k,gpt-3.5-turbo-0301,text-davinci-003,gpt-4,gpt-4-0314,gpt-4-0613"

    DEBUG_OPENAI = false

    # TITLE_CONVO        = false
    # OPENAI_TITLE_MODEL = "gpt-3.5-turbo"

    # OPENAI_SUMMARIZE     = true
    # OPENAI_SUMMARY_MODEL = "gpt-3.5-turbo"

    # OPENAI_FORCE_PROMPT  = true

    # OPENAI_REVERSE_PROXY = "<YOUR REVERSE PROXY>"

    #============#
    # OpenRouter #
    #============#

    # OPENROUTER_API_KEY =

    #============#
    # Plugins    #
    #============#

    # PLUGIN_MODELS = "gpt-3.5-turbo,gpt-3.5-turbo-16k,gpt-3.5-turbo-0301,gpt-4,gpt-4-0314,gpt-4-0613"

    DEBUG_PLUGINS = true

    CREDS_KEY = random_string.creds_key.result
    CREDS_IV  = random_string.creds_iv.result

    # Azure AI Search
    #-----------------
    # AZURE_AI_SEARCH_SERVICE_ENDPOINT=
    # AZURE_AI_SEARCH_INDEX_NAME=
    # AZURE_AI_SEARCH_API_KEY=

    # AZURE_AI_SEARCH_API_VERSION=
    # AZURE_AI_SEARCH_SEARCH_OPTION_QUERY_TYPE=
    # AZURE_AI_SEARCH_SEARCH_OPTION_TOP=
    # AZURE_AI_SEARCH_SEARCH_OPTION_SELECT=

    # DALL·E 3
    #----------------
    # DALLE_API_KEY=
    # DALLE3_SYSTEM_PROMPT="Your System Prompt here"
    # DALLE_REVERSE_PROXY=

    # Google
    #-----------------
    # GOOGLE_API_KEY=
    # GOOGLE_CSE_ID=

    # SerpAPI
    #-----------------
    # SERPAPI_API_KEY=

    # Stable Diffusion
    #-----------------
    # SD_WEBUI_URL=http://host.docker.internal:7860

    # WolframAlpha
    #-----------------
    # WOLFRAM_APP_ID=

    # Zapier
    #-----------------
    # ZAPIER_NLA_API_KEY=

    #==================================================#
    #                      Search                      #
    #==================================================#

    SEARCH             = true
    MEILI_NO_ANALYTICS = true
    MEILI_HOST         = "${azurerm_linux_web_app.meilisearch.name}.azurewebsites.net"
    # MEILI_HTTP_ADDR=0.0.0.0:7700
    MEILI_MASTER_KEY = random_string.meilisearch_master_key.result

    #===================================================#
    #                    User System                    #
    #===================================================#

    #========================#
    # Moderation             #
    #========================#

    BAN_VIOLATIONS = true
    BAN_DURATION   = 1000 * 60 * 60 * 2
    BAN_INTERVAL   = 20

    LOGIN_VIOLATION_SCORE        = 1
    REGISTRATION_VIOLATION_SCORE = 1
    CONCURRENT_VIOLATION_SCORE   = 1
    MESSAGE_VIOLATION_SCORE      = 1
    NON_BROWSER_VIOLATION_SCORE  = 20

    LOGIN_MAX       = 7
    LOGIN_WINDOW    = 5
    REGISTER_MAX    = 5
    REGISTER_WINDOW = 60

    LIMIT_CONCURRENT_MESSAGES = true
    CONCURRENT_MESSAGE_MAX    = 2

    LIMIT_MESSAGE_IP  = true
    MESSAGE_IP_MAX    = 40
    MESSAGE_IP_WINDOW = 1

    LIMIT_MESSAGE_USER  = false
    MESSAGE_USER_MAX    = 40
    MESSAGE_USER_WINDOW = 1

    #========================#
    # Balance                #
    #========================#

    CHECK_BALANCE = false

    #========================#
    # Registration and Login #
    #========================#

    ALLOW_EMAIL_LOGIN         = true
    ALLOW_REGISTRATION        = true
    ALLOW_SOCIAL_LOGIN        = false
    ALLOW_SOCIAL_REGISTRATION = false

    SESSION_EXPIRY       = 1000 * 60 * 15
    REFRESH_TOKEN_EXPIRY = (1000 * 60 * 60 * 24) * 7

    JWT_SECRET         = random_string.jwt_secret.result
    JWT_REFRESH_SECRET = random_string.jwt_refresh_secret.result

    # Discord
    # DISCORD_CLIENT_ID=
    # DISCORD_CLIENT_SECRET=
    # DISCORD_CALLBACK_URL=/oauth/discord/callback

    # Facebook
    # FACEBOOK_CLIENT_ID=
    # FACEBOOK_CLIENT_SECRET=
    # FACEBOOK_CALLBACK_URL=/oauth/facebook/callback

    # GitHub
    # GITHUB_CLIENT_ID=
    # GITHUB_CLIENT_SECRET=
    # GITHUB_CALLBACK_URL=/oauth/github/callback

    # Google
    # GOOGLE_CLIENT_ID=
    # GOOGLE_CLIENT_SECRET=
    # GOOGLE_CALLBACK_URL=/oauth/google/callback

    # OpenID
    # OPENID_CLIENT_ID=
    # OPENID_CLIENT_SECRET=
    # OPENID_ISSUER=
    # OPENID_SESSION_SECRET=
    # OPENID_SCOPE="openid profile email"
    # OPENID_CALLBACK_URL=/oauth/openid/callback

    # OPENID_BUTTON_LABEL=
    # OPENID_IMAGE_URL=

    #========================#
    # Email Password Reset   #
    #========================#

    # EMAIL_SERVICE=                  
    # EMAIL_HOST=                     
    # EMAIL_PORT=25                   
    # EMAIL_ENCRYPTION=               
    # EMAIL_ENCRYPTION_HOSTNAME=      
    # EMAIL_ALLOW_SELFSIGNED=         
    # EMAIL_USERNAME=                 
    # EMAIL_PASSWORD=                 
    # EMAIL_FROM_NAME=                
    # EMAIL_FROM=noreply@librechat.ai

    #==================================================#
    #                      Others                      #
    #==================================================#
    #   You should leave the following commented out   #

    # NODE_ENV=

    # REDIS_URI=
    # USE_REDIS=

    # E2E_USER_EMAIL=
    # E2E_USER_PASSWORD=

    #=============================================================#
    #                   Azure App Service Configuration           #
    #=============================================================#

    WEBSITE_RUN_FROM_PACKAGE            = "1"
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
