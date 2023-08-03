# LibreChatAzureDeployment
A Terraform setup to deploy [LibreChat](https://github.com/danny-avila/LibreChat) to Azure and setup all the necessary services.

# Azure Deployment Instructions

## Prerequisites

You must have an existing Azure subscription for this to work.

## Steps

1. **Clone the repository.**
   
2. **Open in VS-Code Devcontainer.**

3. **[Optional] Configure Deployment:**
    * Edit `terraform.tfvars` to customize your deployment. 
    * You can for example set the `MONGO_URI` which is the connection string to your MongoDB. A fast and simple solution for that is a free cloud instance, like setting up an [Atlas Instance](https://github.com/danny-avila/LibreChat/blob/main/docs/install/mongodb.md). By default a CosmosDB instance is set up automatically.

4. **Azure Login:** Open the Terminal inside of VS-Code, and run the command `az login`.

5. **Terraform Initialization:** In the Terminal inside of VS-Code, run the command `terraform init`.

6. **Apply Terraform Configuration:** In the Terminal inside of VS-Code, run the command `terraform apply`.

7. **Open LibreChat:** After finishing, terraform shows the outputs in the terminal. Open the Url of "libre_chat_url" (it might take some minutes until everything has booted)
## Teardown

To tear down your Azure resources, run the command `terraform destroy` in the Terminal inside of VS-Code.

