# LibreChatAzureDeployment
A Terraform setup to deploy [LibreChat](https://github.com/danny-avila/LibreChat) to Azure and setup all the necessary services.

## How to Set Up

To enable Google login, you must create an application in the [Google Cloud Console](https://cloud.google.com) and provide the client ID and client secret in the `/.env` file.

1. Clone the repo
2. Open in VS-Code Devcontainer
3. [Optionally] edit terraform.tfvars to customize your deployment
4. In the Terminal inside of VS-Code, run ```terraform init```
5. In the Terminal inside of VS-Code, run ```terraform apply```

   To tear down your Azure ressources, run ```terraform destroy```
