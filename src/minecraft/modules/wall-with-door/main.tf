locals {
  dx = var.direction == "east" ? 1 : 0
  dz = var.direction == "north" ? 1 : 0

  origin = var.start_position

  offset_0_0 = {
    x = local.origin.x + 0 * local.dx + 0 * local.dz
    z = local.origin.z + 0 * local.dz + 0 * local.dx
  }
  offset_1_0 = {
    x = local.origin.x + 1 * local.dx + 0 * local.dz
    z = local.origin.z + 1 * local.dz + 0 * local.dx
  }
  offset_2_0 = {
    x = local.origin.x + 2 * local.dx + 0 * local.dz
    z = local.origin.z + 2 * local.dz + 0 * local.dx
  }
  offset_3_0 = {
    x = local.origin.x + 3 * local.dx + 0 * local.dz
    z = local.origin.z + 3 * local.dz + 0 * local.dx
  }
}

module "top_beam" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_0_0.x
    y = local.origin.y + 2
    z = local.offset_0_0.z
  }

  width  = var.direction == "east" ? 4 : 1
  length = 2
  depth  = var.direction == "east" ? 1 : 4
}

module "left_post" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_0_0.x
    y = local.origin.y
    z = local.offset_0_0.z
  }

  width  = 1
  length = 2
  depth  = 1

  depends_on = [module.top_beam]
}

module "right_post" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_3_0.x
    y = local.origin.y
    z = local.offset_3_0.z
  }

  width  = 1
  length = 2
  depth  = 1

  depends_on = [module.top_beam]
}
