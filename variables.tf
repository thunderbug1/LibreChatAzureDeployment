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

variable "app_service_sku_name" {
  description = "size of the VM that runs the librechat app. F1 is free but limited to 1h per day."
  default = "B1"
}

variable "mongo_uri" {
  description = "Connection string for the mongodb"
  default = ""
  sensitive = true
}

# variable "deployments" {
#   description = "(Optional) Specifies the deployments of the Azure OpenAI Service"
#   type = list(object({
#     name = string
#     model = object({
#       name = string
#       version = string
#     })
#     rai_policy_name = string  
#   }))
#   default = [
#     {
#       name = "gpt-35-turbo"
#       model = {
#         name = "gpt-35-turbo"
#         version = "0301"
#       }
#       rai_policy_name = ""
#     }
#   ] 
# }

variable "public_network_access_enabled" {
  description = "(Optional) Specifies whether public network access is allowed for the Azure OpenAI Service"
  type = bool
  default = false
}