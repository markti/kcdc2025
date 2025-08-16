locals {
  default_address_space = cidrsubnet(var.base_address_space, 2, 1)
}
resource "azurerm_subnet" "default" {
  name                 = "snet-default"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.default_address_space]
}

resource "azurerm_network_security_group" "minecraft" {
  name                = "nsg-minecraft"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

}

resource "azurerm_network_security_rule" "minecraft_game_port" {

  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.minecraft.name
  name                        = "game-port"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "19132-19133"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

}

resource "azurerm_network_security_rule" "minecraft_java_port" {

  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.minecraft.name
  name                        = "minecraft-java"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "25565"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

}

resource "azurerm_network_security_rule" "rcon_port" {

  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.minecraft.name
  name                        = "rcon-java"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "25575"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

}

resource "azurerm_subnet_network_security_group_association" "minecraft" {
  subnet_id                 = azurerm_subnet.default.id
  network_security_group_id = azurerm_network_security_group.minecraft.id
}
