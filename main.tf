provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

module "linuxservers" {
  source                        = "Azure/compute/azurerm"
  resource_group_name           = azurerm_resource_group.example.name
  vm_hostname                   = "mylinuxvm"
  nb_public_ip                  = 0
  remote_port                   = "22"
  nb_instances                  = 2
  vm_os_publisher               = "Canonical"
  vm_os_offer                   = "UbuntuServer"
  vm_os_sku                     = "18.04-LTS"
  vnet_subnet_id                = module.network.vnet_subnets[0]
  boot_diagnostics              = true
  delete_os_disk_on_termination = true
  nb_data_disk                  = 2
  data_disk_size_gb             = 64
  data_sa_type                  = "Premium_LRS"
  enable_ssh_key                = true
  vm_size                       = "Standard_D4s_v3"

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  enable_accelerated_networking = true
}

module "windowsservers" {
  source                        = "Azure/compute/azurerm"
  resource_group_name           = azurerm_resource_group.example.name
  vm_hostname                   = "mywinvm"
  is_windows_image              = true
  admin_password                = "ComplxP@ssw0rd!"
  public_ip_dns                 = ["winterravmip", "winterravmip1"]
  nb_public_ip                  = 2
  remote_port                   = "3389"
  nb_instances                  = 2
  vm_os_publisher               = "MicrosoftWindowsServer"
  vm_os_offer                   = "WindowsServer"
  vm_os_sku                     = "2012-R2-Datacenter"
  vm_size                       = "Standard_DS2_V2"
  vnet_subnet_id                = module.network.vnet_subnets[0]
  enable_accelerated_networking = true
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]
}

output "linux_vm_private_ips" {
  value = module.linuxservers.network_interface_private_ip
}

output "windows_vm_public_name" {
  value = module.windowsservers.public_ip_dns_name
}

output "windows_vm_public_ip" {
  value = module.windowsservers.public_ip_address
}

output "windows_vm_private_ips" {
  value = module.windowsservers.network_interface_private_ip
}
