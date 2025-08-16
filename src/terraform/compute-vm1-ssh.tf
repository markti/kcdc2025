resource "tls_private_key" "vm1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "vm1_ssh_private" {

  name         = "vm1-ssh-private"
  value        = tls_private_key.vm1.private_key_pem
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.terraform_user]
}

resource "azurerm_key_vault_secret" "vm1_ssh_public" {

  name         = "vm1-ssh-public"
  value        = tls_private_key.vm1.public_key_openssh
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.terraform_user]
}