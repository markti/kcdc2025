locals {
  positions = flatten([
    for x in range(var.width) : [
      for z in range(var.depth) : {
        x_offset = x
        z_offset = z
      }
    ]
  ])
}

module "pillars" {
  for_each = {
    for pos in local.positions :
    "${pos.x_offset}-${pos.z_offset}" => pos
  }

  source   = "../pillar"
  material = var.material
  length   = var.length

  start_position = {
    x = var.start_position.x + each.value.x_offset
    y = var.start_position.y
    z = var.start_position.z + each.value.z_offset
  }
}
