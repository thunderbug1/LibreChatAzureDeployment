# LibreChatAzureDeployment
A Terraform setup to deploy [LibreChat](https://github.com/danny-avila/LibreChat) to Azure and setup all the necessary services.

## How to Set Up
You must have an existing Azure subscription for this to work.

1. Clone the repo
2. Open in VS-Code Devcontainer
3. In the Terminal inside of VS-Code, run ```az login```
4. edit terraform.tfvars to customize your deployment
4.1. you will need to set the MONGO_URI which is the connection string to your MongoDB
     A fast and simple solution for that is a free cloud instance, [setup Atlas Instance](https://github.com/danny-avila/LibreChat/blob/main/docs/install/mongodb.md)
5. In the Terminal inside of VS-Code, run ```terraform init```
6. In the Terminal inside of VS-Code, run ```terraform apply```

   To tear down your Azure ressources, run ```terraform destroy```
