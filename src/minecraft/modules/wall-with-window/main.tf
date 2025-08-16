locals {
  # Axis multipliers for rotation
  dx = var.direction == "east" ? 1 : 0
  dz = var.direction == "north" ? 1 : 0

  origin = var.start_position

  # Reusable offset calculator for rotated x/z
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

# Bottom beam (horizontal line at bottom)
module "bottom_beam" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_0_0.x
    y = var.start_position.y
    z = local.offset_0_0.z
  }
  width  = var.direction == "east" ? 4 : 1
  length = 1
  depth  = var.direction == "east" ? 1 : 4
}

# Top beam
module "top_beam" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_0_0.x
    y = local.origin.y + 3
    z = local.offset_0_0.z
  }

  width  = var.direction == "east" ? 4 : 1
  length = 1
  depth  = var.direction == "east" ? 1 : 4
}

# Glass window
module "glass_window" {
  source   = "../cuboid"
  material = var.glass_material
  start_position = {
    x = local.offset_1_0.x
    y = local.origin.y + 1
    z = local.offset_1_0.z
  }

  width  = var.direction == "east" ? 2 : 1
  length = 2
  depth  = var.direction == "east" ? 1 : 2
}


# Left post (vertical support)
module "left_post" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_0_0.x
    y = local.origin.y + 1
    z = local.offset_0_0.z
  }

  width  = 1
  length = 2
  depth  = 1

  depends_on = [module.bottom_beam, module.top_beam]
}

# Right post (vertical support)
module "right_post" {
  source   = "../cuboid"
  material = var.material
  start_position = {
    x = local.offset_3_0.x
    y = local.origin.y + 1
    z = local.offset_3_0.z
  }

  width  = 1
  length = 2
  depth  = 1

  depends_on = [module.bottom_beam, module.top_beam]
}
