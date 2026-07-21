resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "this" {
  name                = "SSH-PUBLIC-KEY"
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = tls_private_key.this.public_key_openssh
}
