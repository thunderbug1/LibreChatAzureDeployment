# output "mongo_connection_string" {
#   description = "Connection string for the MongoDB"
#   value       = azurerm_cosmosdb_account.librechat.connection_strings[0]
#   sensitive = true
# }

output "ressource_group_name" {
  description = "name of the created ressource group"
  value       = data.azurerm_resource_group.this.name
}

output "libre_chat_url" {
  value = "${data.azurerm_linux_web_app.existing_webapp.name}.azurewebsites.net"
}

output "meilisearch_url" {
  value = "${azurerm_linux_web_app.meilisearch.name}.azurewebsites.net"
}

output "azure_openai_api_key" {
  value = "${var.azure_openai_key}"
  sensitive = true
}

output "azure_openai_endpoint" {
  value = "${var.azure_openai_instance_name}"
  sensitive = true
}


# output "meilisearch_master_key" {
#   description = "MeiliSearch Master Key"
#   value       = random_string.meilisearch_master_key
# }
