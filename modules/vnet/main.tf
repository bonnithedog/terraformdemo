provider "azurerm" {
  features {}
}


  module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = var.rgname
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  #nsg_ids = {
  #  subnet1 = azurerm_network_security_group.ssh.id
  #  subnet2 = azurerm_network_security_group.ssh.id
  #  subnet3 = azurerm_network_security_group.ssh.id
  #}


  #tags = {
  #  environment = "dev"
  #  costcenter  = "it"
  #}


resource "azurerm_network_security_group" "ssh" {
  depends_on          = [module.vnet]
  name                = "ssh"
  location            = var.location
  #resource_group_name = "${var.resource_group_name}" 
  resource_group_name = var.rgname 
  


  security_rule {
    name                       = "SSHinbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

security_rule {
    name                       = "HTTPSinbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



}