data "azurerm_shared_image_version" "vm3" {
  name                = "2025.07.7"
  image_name          = "ubuntu-minecraft-java"
  gallery_name        = var.azure_gallery_name
  resource_group_name = var.azure_gallery_resource_group
}

module "vm3" {

  source = "./modules/simple-vm"

  name                = "${var.application_name}-${var.environment_name}-vm3"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  additional_tags     = var.additional_tags
  admin_user          = var.admin_user
  subnet_id           = azurerm_subnet.default.id
  vm_size             = var.vm_size
  vm_image_id         = data.azurerm_shared_image_version.vm3.id
  ssh_public_key      = tls_private_key.vm1.public_key_openssh

}
