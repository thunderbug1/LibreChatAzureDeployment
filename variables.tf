variable "location" {
  description = "The location where all resources will be deployed"
  default     = "westeurope"
}

variable "app_title" {
  description = "The title that librechat will display"
  default     = "librechat"
}

variable "openai_key" {
  description = "OpenAI API Key"
  default = ""
  sensitive = true
}

variable "chatgpt_token" {
  description = "ChatGPT Token"
  default = "user_provided"
  sensitive = true
}

variable "anthropic_api_key" {
  description = "Anthropic API Key"
  default = "user_provided"
  sensitive = true
}

variable "bingai_token" {
  description = "BingAI Token"
  default = "user_provided"
  sensitive = true
}

variable "palm_key" {
  description = "PaLM Key"
  default = "user_provided"
  sensitive = true
}

variable "app_service_sku_name" {
  description = "size of the VM that runs the librechat app. F1 is free but limited to 1h per day."
  default = "B1"
}

variable "mongo_uri" {
  description = "Connection string for the mongodb"
  default = ""
  sensitive = true
}

variable "use_cosmosdb_free_tier" {
  description = "Flag to enable/disable free tier of cosmosdb. This needs to be false if another instance already uses free tier."
  default = true
}

variable "deployments" {
  description = "(Optional) Specifies the deployments of the Azure OpenAI Service"
  type = map(object({
    name = string
    rai_policy_name = string
    model_format = string
    model_name = string
    model_version = string
    scale_type = string
  }))
  default = {
    "chat_model" = {
      name = "gpt-35-turbo"
      rai_policy_name = "Microsoft.Default"
      model_name = "gpt-35-turbo"
      model_format = "OpenAI"
      model_version = "0301"
      scale_type = "Standard"
    },
    "embedding_model" = {
      name = "text-embedding-ada-002"
      rai_policy_name = "Microsoft.Default"
      model_format = "OpenAI"
      model_name = "text-embedding-ada-002"
      model_version = "2"
      scale_type = "Standard"
    }
  }
}

variable "azure_openai_api_deployment_name" {
  description = "(Optional) The deployment name of your Azure OpenAI API; if deployments.chat_model.name is defined, the default value is that value."
  default = ""
}

variable "azure_openai_api_completions_deployment_name" {
  description = "(Optional) The deployment name for completion; if deployments.chat_model.name is defined, the default value is that value."
  default = ""
}

variable "azure_openai_api_version" {
  description = "The version of your Azure OpenAI API"
  default = "2023-05-15"
}

variable "azure_openai_api_embeddings_deployment_name" {
  description = "(Optional) The deployment name for embedding; if deployments.embedding_model.name is defined, the default value is that value."
  default = ""
}

variable "public_network_access_enabled" {
  description = "(Optional) Specifies whether public network access is allowed for the Azure OpenAI Service"
  type = bool
  default = false
}
