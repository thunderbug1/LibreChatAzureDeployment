# LibreChatAzureDeployment
A Terraform setup to deploy [LibreChat](https://github.com/danny-avila/LibreChat) to Azure and setup all the necessary services.

## How to Set Up
You must have an existing Azure subscription for this to work.

1. Clone the repo
2. Open in VS-Code Devcontainer
3. In the Terminal inside of VS-Code, run ```az login```
4. [Optionally] edit terraform.tfvars to customize your deployment
5. In the Terminal inside of VS-Code, run ```terraform init```
6. In the Terminal inside of VS-Code, run ```terraform apply```

   To tear down your Azure ressources, run ```terraform destroy```
