locals {
  dx = var.direction == "east" ? 1 : 0
  dz = var.direction == "north" ? 1 : 0

  arch_offsets = [
    for i in range(var.arch_count) : {
      x = var.start_position.x + i * var.arch_length * local.dx
      y = var.start_position.y
      z = var.start_position.z + i * var.arch_length * local.dz
    }
  ]
}

module "arches" {
  for_each = {
    for idx, pos in local.arch_offsets : idx => pos
  }

  source    = "../arch"
  material  = var.material
  length    = var.arch_length
  direction = var.direction
  start_position = {
    x = each.value.x
    y = each.value.y
    z = each.value.z
  }
}
