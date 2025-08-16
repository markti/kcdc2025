locals {
  dx = var.direction == "E" ? 1 : var.direction == "W" ? -1 : 0
  dy = var.direction == "UP" ? 1 : var.direction == "DOWN" ? -1 : 0
  dz = var.direction == "S" ? 1 : var.direction == "N" ? -1 : 0

  blocks = [
    for i in range(var.length) : {
      x   = var.start_position.x + i * local.dx
      y   = var.start_position.y + i * local.dy
      z   = var.start_position.z + i * local.dz
      key = "b_${i}"
    }
  ]
}

resource "minecraft_block" "pillar" {
  for_each = {
    for b in local.blocks : b.key => b
  }

  material = var.material

  position = {
    x = each.value.x
    y = each.value.y
    z = each.value.z
  }
}