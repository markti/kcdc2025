locals {
  arch_profiles = {
    6  = [0, 3, 4, 4, 3, 0]
    8  = [0, 2, 4, 5, 5, 4, 2, 0]
    10 = [0, 2, 4, 5, 6, 6, 6, 5, 4, 2]
    12 = [0, 2, 4, 6, 6, 7, 7, 7, 6, 6, 4, 2]
    14 = [0, 2, 4, 6, 7, 8, 8, 8, 8, 7, 6, 4, 2, 0]
    16 = [0, 2, 4, 6, 7, 8, 9, 9, 9, 9, 8, 7, 6, 4, 2, 0]
    18 = [0, 2, 4, 6, 8, 9, 10, 10, 10, 10, 10, 10, 9, 8, 6, 4, 2, 0]
    20 = [0, 2, 4, 6, 8, 9, 10, 11, 11, 11, 11, 11, 11, 10, 9, 8, 6, 4, 2, 0]
    22 = [0, 2, 4, 6, 8, 9, 10, 11, 12, 12, 12, 12, 12, 12, 11, 10, 9, 8, 6, 4, 2, 0]
    24 = [0, 2, 4, 6, 8, 9, 10, 11, 12, 13, 13, 13, 13, 13, 13, 12, 11, 10, 9, 8, 6, 4, 2, 0]
    26 = [0, 2, 4, 6, 8, 10, 11, 12, 13, 13, 14, 14, 14, 14, 14, 13, 13, 12, 11, 10, 8, 6, 4, 2, 0]
    28 = [0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 14, 15, 15, 15, 15, 15, 14, 14, 13, 12, 11, 10, 8, 6, 4, 2, 0]
    30 = [0, 2, 4, 6, 8, 10, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 15, 15, 14, 13, 12, 10, 8, 6, 4, 2, 0]
    32 = [0, 2, 4, 6, 8, 10, 12, 13, 14, 15, 16, 16, 17, 17, 17, 17, 17, 17, 16, 16, 15, 14, 13, 12, 10, 8, 6, 4, 2, 0]
  }

  dx = var.direction == "east" ? 1 : 0
  dz = var.direction == "north" ? 1 : 0

  origin       = var.start_position
  arch_heights = try(local.arch_profiles[var.length], [])
  arch_top     = max([for h in local.arch_heights : h]...)

  arch_blocks = flatten([
    for i, base_height in local.arch_heights : [
      for y_offset in range(local.arch_top - base_height + 1) : {
        x = local.origin.x + i * local.dx
        y = local.origin.y + base_height + y_offset
        z = local.origin.z + i * local.dz
      }
    ]
  ])
}

resource "minecraft_block" "arch" {
  for_each = {
    for idx, pt in local.arch_blocks : "${pt.x}-${pt.y}-${pt.z}" => pt
  }

  material = var.material

  position = {
    x = each.value.x
    y = each.value.y
    z = each.value.z
  }
}
