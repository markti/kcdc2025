variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "location" {
  type = string
}
variable "additional_tags" {
  type    = map(string)
  default = {}
}
variable "base_address_space" {
  type = string
}
variable "azure_gallery_name" {
  type = string
}
variable "azure_gallery_resource_group" {
  type = string
}
variable "admin_user" {
  type = string
}
variable "vm_size" {
  type = string
}
