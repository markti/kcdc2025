locals {
  layers = flatten([
    for i in range(0, 100) : [
      {
        offset_x = i
        offset_z = i
        length   = var.length - 2 * i
        width    = var.length - 2 * i
        y        = var.start_position.y + i
      }
    ]
    if var.length - 2 * i >= 2 && var.length - 2 * i >= 2
  ])
}

module "pyramid_layers" {
  for_each = {
    for i, layer in local.layers : "layer_${i}" => layer
  }

  source   = "../cuboid"
  material = var.material

  start_position = {
    x = var.start_position.x + each.value.offset_x
    y = each.value.y
    z = var.start_position.z + each.value.offset_z
  }

  width  = each.value.length
  length = 1
  depth  = each.value.width
}
