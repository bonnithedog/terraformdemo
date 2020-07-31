

#create resource group
module "resource_group" "example" {
    source    = "./modules/rg"
    #name    = "demo"
    #location = "westus"
}

