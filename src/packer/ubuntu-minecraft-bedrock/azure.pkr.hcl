source "azure-arm" "vm" {

  client_id          = var.arm_client_id
  subscription_id    = var.arm_subscription_id
  tenant_id          = var.arm_tenant_id
  oidc_request_token = var.arm_oidc_request_token
  oidc_request_url   = var.arm_oidc_request_url

  image_offer     = var.azure_marketplace_image.offer
  image_publisher = var.azure_marketplace_image.publisher
  image_sku       = var.azure_marketplace_image.sku

  managed_image_name                = "${var.image_name}-${var.image_version}"
  managed_image_resource_group_name = var.azure_managed_image_destination

  shared_image_gallery_destination {
    gallery_name   = var.azure_gallery_name
    resource_group = var.azure_gallery_resource_group
    image_name     = var.image_name
    image_version  = var.image_version
  }

  location                     = var.azure_primary_location
  communicator                 = "ssh"
  os_type                      = "Linux"
  vm_size                      = var.azure_vm_size
  allowed_inbound_ip_addresses = [var.agent_ipaddress]

}