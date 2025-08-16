locals {
  layers = flatten([
    for i in range(1, 100) : [
      {
        offset = i
        length = var.length - 2 * i
        y      = var.start_position.y + i
      }
    ]
    if var.length - 2 * i >= 2
  ])
}

module "base_layer" {
  source   = "../cuboid"
  material = var.material

  start_position = {
    x = var.start_position.x
    y = var.start_position.y
    z = var.start_position.z
  }

  width  = var.length
  depth  = var.length
  length = 1
}

module "frame_layers" {
  for_each = {
    for i, layer in local.layers : "layer_${i}" => layer
  }

  source   = "../square-frame"
  material = var.material

  start_position = {
    x = var.start_position.x + each.value.offset
    y = each.value.y
    z = var.start_position.z + each.value.offset
  }

  length = each.value.length
}
