# LibreChatAzureDeployment
A Terraform setup to deploy [LibreChat](https://github.com/danny-avila/LibreChat) to Azure and setup all the necessary services.

# Azure Deployment Instructions

## Prerequisites

You must have an existing Azure subscription for this to work.

## Steps

1. **Clone the repository.**
   
2. **Open in VS-Code Devcontainer.**

3. **Configure Deployment:**
    * Edit `terraform.tfvars` to customize your deployment. 
    * You will need to set the `MONGO_URI` which is the connection string to your MongoDB. A fast and simple solution for that is a free cloud instance, like setting up an Atlas Instance.

4. **Azure Login:** Open the Terminal inside of VS-Code, and run the command `az login`.

5. **Terraform Initialization:** In the Terminal inside of VS-Code, run the command `terraform init`.

6. **Apply Terraform Configuration:** In the Terminal inside of VS-Code, run the command `terraform apply`.

## Teardown

To tear down your Azure resources, run the command `terraform destroy` in the Terminal inside of VS-Code.

