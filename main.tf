provider "azurerm" {
  features {}
}


#create resource group
module "resource_group" "rg" {
    source    = "./modules/rg"
    rgname    = "demo"
    location = "westus"
}

