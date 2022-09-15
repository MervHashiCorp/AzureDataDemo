
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
resource "azurerm_resource_group" "synapse" {
  name = "rg_synapse"
  localocation = var.location  
}
resource "azurerm_storage_account" "synapse" {
  name                     = "synapsestorageacc"
  resource_group_name      = azurerm_resource_group.synapse.name
  location                 = azurerm_resource_group.synapse.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}
resource "azurerm_storage_data_lake_gen2_filesystem" "synapse" {
  name               = "synapse"
  storage_account_id = azurerm_storage_account.synapse.id
}
resource "azurerm_synapse_workspace" "synapse" {
  name                                 = "synapse"
  resource_group_name                  = azurerm_resource_group.synapse.name
  location                             = azurerm_resource_group.synapse.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.synapse.id
  sql_administrator_login              = "mervsqladminuser"
  sql_administrator_login_password     = "Synapse@123"
    identity {
    type = "SystemAssigned"
  }
  tags = {
    owner = "mervyn.yan@hsaahicorp.com"
    purpose = "demo"
    region = "emea-emerging"
  }
}
