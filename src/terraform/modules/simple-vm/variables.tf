variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "additional_tags" {
  type    = map(string)
  default = {}
}
variable "admin_user" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "vm_image_id" {
  type = string
}
variable "ssh_public_key" {
  type = string
}
