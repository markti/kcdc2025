module "north_side" {
  source = "../pillar"
  start_position = {
    x = var.start_position.x
    y = var.start_position.y
    z = var.start_position.z
  }
  length    = var.length
  direction = "E"
  material  = var.material
}

module "south_side" {
  source = "../pillar"
  start_position = {
    x = var.start_position.x
    y = var.start_position.y
    z = var.start_position.z + var.length - 1
  }
  length    = var.length
  direction = "E"
  material  = var.material
}

module "west_side" {
  source = "../pillar"
  start_position = {
    x = var.start_position.x
    y = var.start_position.y
    z = var.start_position.z
  }
  length    = var.length
  direction = "S"
  material  = var.material
}

module "east_side" {
  source = "../pillar"
  start_position = {
    x = var.start_position.x + var.length - 1
    y = var.start_position.y
    z = var.start_position.z
  }
  length    = var.length
  direction = "S"
  material  = var.material
}
