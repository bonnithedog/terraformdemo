provider "azurerm" {
  features {}
}


#create resource group
module "resource_group" "rg" {
    source    = "./modules/rg"
    name    = "demo"
    location = "westus"
}

