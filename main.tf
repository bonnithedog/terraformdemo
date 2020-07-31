

#create resource group
module "resource_group" {
    source    = "./modules/rg"
    rgname    = var.envset
    location  = var.location
}

##create azurerm_network_security_group group
#module "network_security_group" {
#    source    = "./modules/nsg"
#    rgname    = var.envset
#    location  = var.location
#}



module "vnet" {
    source    = "./modules/vnet"
    address_space       = ["10.0.0.0/16"]
    subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    subnet_names        = ["subnet1", "subnet2", "subnet3"]
    rgname    = var.envset
    location  = var.location

  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  }