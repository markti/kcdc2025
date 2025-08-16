variable "arm_subscription_id" {
  type    = string
}
variable "arm_tenant_id" {
  type    = string
}
variable "arm_client_id" {
  type    = string
}
variable "arm_oidc_request_token" {
  type = string
}
variable "arm_oidc_request_url" {
  type = string
}
variable "image_name" {
  type = string
}
variable "image_version" {
  type = string
}
variable "agent_ipaddress" {
  type = string
}
variable "azure_primary_location" {
  type = string
}
variable "azure_vm_size" {
  type = string
}
variable "azure_managed_image_destination" {
  type = string
}
variable "azure_gallery_name" {
  type = string
}
variable "azure_gallery_resource_group" {
  type = string
}
variable "azure_marketplace_image" {
  type = object({
    offer     = string
    publisher = string
    sku       = string
  })
}
variable "minecraft_server_name" {
  type = string
}
variable "minecraft_game_mode" {
  type = string
}
variable "minecraft_difficulty" {
  type = string
}
variable "minecraft_allow_cheats" {
  type = bool
}
variable "minecraft_max_players" {
  type = number
}
variable minecraft_allow_list {
  type = bool
}
variable "minecraft_level_name" {
  type = string
}
variable "minecraft_level_seed" {
  type = string
}
variable minecraft_detault_permission_level {
  type = string
}
variable "minecraft_operator" {
  type = string
}