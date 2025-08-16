locals {
  execute_command    = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
  service_name       = "mcjava"
  service_username   = "mcserver"
  server_folder_name = "minecraft_java"
  server_folder_path = "/home/${local.service_username}/${local.server_folder_name}"
}