locals {
  execute_command    = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
  service_name       = "mcbedrock"
  service_username   = "mcserver"
  server_folder_name = "minecraft_bedrock"
  server_folder_path = "/home/${local.service_username}/${local.server_folder_name}"
}