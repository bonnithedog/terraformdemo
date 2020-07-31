provider "azurerm" {
  features {}
}


#create resource group
module "resource_group" "rg" {
    source    = "./modules/rg"
    sgname    = "demo"
    location = "westus"
}

