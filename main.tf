#Init
terraform {
  cloud {
    organization = "MervTrainingOrg"
    hostname = "app.terraform.io"
    workspaces = "AzureDataDemo"
  }

required_providers {
  azurerm = {
    source = "hashicorp/azurerm"
    version = "3.22.0"
  }
}
}

#Providers
provider = "azurerm" {
  features {}
}
