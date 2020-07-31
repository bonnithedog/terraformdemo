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
