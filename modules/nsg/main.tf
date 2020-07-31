provider "azurerm" {
  features {}
}


resource "random_id" "rg_name" {
  byte_length = 2
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "test-${random_id.rg_name.hex}-nsg"
  resource_group_name = var.rgname.name
  location            = var.rgname.location
}


resource "random_id" "rg_name" {
  byte_length = 8
}


resource "azurerm_network_security_group" "nsg1" {
  name                = "test-${random_id.rg_name.hex}-nsg"
  resource_group_name = avar.rgname.name
  location            = var.rgname.location
}

resource "azurerm_route_table" "rt1" {
  location            = var.rgname.location
  name                = "test-${random_id.rg_name.hex}-rt"
  resource_group_name = avar.rgname.name
}

module "vnet" {
  source              = "../../"
  resource_group_name = var.rgname.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  route_tables_ids = {
    subnet1 = azurerm_route_table.rt1.id
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}
  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  route_tables_ids = {
    subnet1 = azurerm_route_table.rt1.id
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

