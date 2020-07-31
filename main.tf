

#create resource group
module "resource_group" {
    source    = "./modules/rg"
    rgname    = var.envset
    location  = var.location
}

#create azurerm_network_security_group group
module "network_security_group" {
    source    = "./modules/nsg"
    rgname    = var.envset
    location  = var.location
}
