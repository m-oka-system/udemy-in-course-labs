resource "random_string" "suffix" {
  length  = 5
  lower   = true
  numeric = true
  upper   = false
  special = false
}

resource "random_password" "admin_password" {
  count = local.has_windows ? 1 : 0

  length           = 16
  upper            = true
  lower            = true
  numeric          = true
  special          = true
  override_special = "!@#%_-"
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}

module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "VNET1"
  address_space       = ["10.0.0.0/16"]
}

module "subnet" {
  source               = "../../modules/subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet.virtual_network_name

  subnet = {
    AzureBastionSubnet = {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.0.0.0/26"]
    }
    Subnet1 = {
      name                            = "Subnet1"
      address_prefixes                = ["10.0.1.0/24"]
      default_outbound_access_enabled = true
    }
  }
}

module "network_security_group" {
  source              = "../../modules/network_security_group"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet              = module.subnet.subnet

  network_security_group = {
    NSG1 = {
      name          = "NSG1"
      target_subnet = "Subnet1"
    }
  }
}

module "ssh_public_key" {
  count = local.has_linux ? 1 : 0

  source              = "../../modules/ssh_public_key"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vm" {
  source              = "../../modules/vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  ssh_public_key      = one(module.ssh_public_key[*].public_key_openssh)
  admin_password      = one(random_password.admin_password[*].result)
  subnet_id           = module.subnet.subnet["Subnet1"].id
  vm                  = local.vms
}
