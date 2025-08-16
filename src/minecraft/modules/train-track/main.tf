locals {
  is_east  = var.direction == "east"
  axis_len = var.length

  offsets = [for i in range(local.axis_len) : i]

  platform_positions = flatten([
    for i in local.offsets : [
      for side in [-1, 0, 1] : {
        x   = local.is_east ? var.start_position.x + i : var.start_position.x + side
        y   = var.start_position.y
        z   = local.is_east ? var.start_position.z + side : var.start_position.z + i
        key = "p_${i}_${side}"
      }
    ]
  ])

  track_positions = [
    for i in local.offsets : {
      x   = local.is_east ? var.start_position.x + i : var.start_position.x
      y   = var.start_position.y + 1
      z   = local.is_east ? var.start_position.z : var.start_position.z + i
      key = "t_${i}"
    }
  ]
}

# Place platform blocks (3-wide)
resource "minecraft_block" "platform" {
  for_each = {
    for pos in local.platform_positions : pos.key => pos
  }

  material = var.platform_material

  position = {
    x = each.value.x
    y = each.value.y
    z = each.value.z
  }
}

# Place center track
resource "minecraft_block" "track" {
  for_each = {
    for pos in local.track_positions : pos.key => pos
  }

  material = var.track_material

  position = {
    x = each.value.x
    y = each.value.y
    z = each.value.z
  }

  depends_on = [minecraft_block.platform]
}

locals {
  torch_positions = [
    for pos in local.track_positions :
    {
      key = pos.key
      x   = pos.x + (var.direction == "north" ? -1 : 0)
      y   = pos.y
      z   = pos.z + (var.direction == "east" ? 1 : 0)
    }
    if tonumber(split("_", pos.key)[1]) % var.redstone_torch_gap == 0
  ]
}

resource "minecraft_block" "torch" {
  for_each = {
    for pos in local.torch_positions : pos.key => pos
  }

  material = "minecraft:redstone_torch"

  position = {
    x = each.value.x
    y = each.value.y
    z = each.value.z
  }
}


locals {
  minecart_position = {
    x = local.track_positions[4].x
    y = local.track_positions[4].y
    z = local.track_positions[4].z + 2
  }
}
