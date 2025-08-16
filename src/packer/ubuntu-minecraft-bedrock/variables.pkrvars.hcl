image_name             = "ubuntu-minecraft-bedrock"
azure_primary_location = "eastus2"
azure_vm_size          = "Standard_DS2_v2"
azure_marketplace_image = {
  offer     = "0001-com-ubuntu-server-jammy"
  publisher = "canonical"
  sku       = "22_04-lts"
}
minecraft_server_name              = "Terracraft"
minecraft_game_mode                = "survival"
minecraft_difficulty               = "hard"
minecraft_allow_cheats             = false
minecraft_max_players              = 10
minecraft_allow_list               = false
minecraft_level_name               = "SMP"
minecraft_level_seed               = ""
minecraft_detault_permission_level = "member"
minecraft_operator                 = "2533274875861754"