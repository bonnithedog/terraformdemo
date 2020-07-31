

#create resource group
module "resource_group" {
    source    = "./modules/rg"
    rgname    = "demo"
    location = "westus"
}

