locals {
  source_image_reference = {
    Linux = {
      offer     = "ubuntu-24_04-lts"
      publisher = "canonical"
      sku       = "server"
      version   = "latest"
    }
    Windows = {
      offer     = "WindowsServer"
      publisher = "MicrosoftWindowsServer"
      sku       = "2022-datacenter-azure-edition-smalldisk"
      version   = "latest"
    }
  }

  patch_mode = {
    Linux   = "ImageDefault"
    Windows = "AutomaticByOS"
  }

  linux_vms = {
    for k, v in var.vm : k => v if v.os_type == "Linux"
  }

  windows_vms = {
    for k, v in var.vm : k => v if v.os_type == "Windows"
  }
}

resource "azurerm_public_ip" "this" {
  for_each = { for k, v in var.vm : k => v if v.public_ip }

  name                = "${each.value.name}-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = ["1", "2", "3"]
}

resource "azurerm_network_interface" "this" {
  for_each = var.vm

  name                = "${each.value.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = each.value.public_ip ? azurerm_public_ip.this[each.key].id : null
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each = local.linux_vms

  name                            = each.value.name
  computer_name                   = each.value.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = each.value.vm_size
  admin_username                  = var.admin_username
  zone                            = each.value.zone
  allow_extension_operations      = each.value.allow_extension_operations
  disable_password_authentication = each.value.disable_password_authentication
  encryption_at_host_enabled      = each.value.encryption_at_host_enabled
  patch_mode                      = local.patch_mode["Linux"]
  secure_boot_enabled             = each.value.secure_boot_enabled
  vtpm_enabled                    = each.value.vtpm_enabled
  custom_data                     = filebase64("${path.module}/userdata.sh")

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  boot_diagnostics {}

  os_disk {
    name                      = "${each.value.name}-os-disk"
    caching                   = each.value.os_disk.os_disk_cache
    storage_account_type      = each.value.os_disk.os_disk_type
    disk_size_gb              = each.value.os_disk.os_disk_size
    write_accelerator_enabled = each.value.os_disk.write_accelerator_enabled
  }

  source_image_reference {
    offer     = local.source_image_reference["Linux"].offer
    publisher = local.source_image_reference["Linux"].publisher
    sku       = local.source_image_reference["Linux"].sku
    version   = local.source_image_reference["Linux"].version
  }
}

resource "azurerm_windows_virtual_machine" "this" {
  for_each = local.windows_vms

  name                       = each.value.name
  computer_name              = each.value.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  size                       = each.value.vm_size
  admin_username             = var.admin_username
  admin_password             = var.admin_password
  zone                       = each.value.zone
  allow_extension_operations = each.value.allow_extension_operations
  encryption_at_host_enabled = each.value.encryption_at_host_enabled
  patch_mode                 = local.patch_mode["Windows"]
  secure_boot_enabled        = each.value.secure_boot_enabled
  vtpm_enabled               = each.value.vtpm_enabled

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]

  boot_diagnostics {}

  os_disk {
    name                      = "${each.value.name}-os-disk"
    caching                   = each.value.os_disk.os_disk_cache
    storage_account_type      = each.value.os_disk.os_disk_type
    disk_size_gb              = each.value.os_disk.os_disk_size
    write_accelerator_enabled = each.value.os_disk.write_accelerator_enabled
  }

  source_image_reference {
    offer     = local.source_image_reference["Windows"].offer
    publisher = local.source_image_reference["Windows"].publisher
    sku       = local.source_image_reference["Windows"].sku
    version   = local.source_image_reference["Windows"].version
  }
}
