resource "azurerm_public_ip" "main" {

  name                = "pip-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  tags = var.additional_tags
}

resource "azurerm_network_interface" "main" {
  name                = "nic-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

  tags = var.additional_tags
}

locals {
  clean_vm_name = replace("vm${var.name}", "-", "")
}

resource "azurerm_user_assigned_identity" "main" {
  name                = "mi-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_linux_virtual_machine" "main" {

  name                = local.clean_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_user
  source_image_id     = var.vm_image_id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = var.admin_user
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.additional_tags
}
