// -1531, 68, -1177

resource "minecraft_block" "stone" {
  material = "minecraft:diamond_block"

  position = {
    x = -1531
    y = 68
    z = -1178
  }

}
resource "minecraft_block" "dirt" {
  material = "minecraft:dirt"

  position = {
    x = -1531
    y = 68
    z = -1177
  }

}

module "p1" {

  source = "./modules/pillar"

  material = "minecraft:dirt"
  length   = 3

  start_position = {
    x = -1532,
    y = 66,
    z = -1177
  }

}

module "island_near_nether_portal" {

  source = "./modules/cuboid"

  material = "minecraft:dirt"
  length   = 3
  width    = 8
  depth    = 8

  start_position = {
    x = -1564,
    y = 60,
    z = -1181
  }

}

module "w1" {
  source = "./modules/small-hut"

  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass_pane"
  start_position = {
    x = -1562,
    y = 63,
    z = -1180
  }

}


module "pyramid" {
  source = "./modules/solid-pyramid"

  material = "minecraft:gold_block"

  start_position = {
    x = -1650,
    y = 62,
    z = -1100
  }
  length = 20

}

module "pyramid2" {

  count = 1

  source = "./modules/pyramid"

  material = "minecraft:diamond_block"
  length   = 20

  start_position = {
    x = -1600,
    y = 62,
    z = -1101
  }

}

module "pyramid3" {

  count = 1

  source = "./modules/pyramid"

  material = "minecraft:iron_block"

  start_position = {
    x = -1600,
    y = 62,
    z = -1151
  }
  length = 20

}

module "train_track" {
  source = "./modules/train-track"

  start_position = {
    x = -1560
    y = 62
    z = -1170
  }
  length    = 200
  direction = "north"

}


// arch
//-1514, 66, -1210
/*
module "arch" {
  source = "./modules/arch"

  start_position = {
    x = -1514
    y = 70
    z = -1210
  }

  material  = "minecraft:stone"
  length    = 8
  direction = "east"

}
*/

module "arch" {
  source = "./modules/arch-wall"

  start_position = {
    x = -1514
    y = 70
    z = -1210
  }

  material    = "minecraft:stone"
  arch_length = 8
  arch_count  = 128
  direction   = "east"

}


module "w3" {

  count = 1

  source = "./modules/small-hut"

  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass_pane"
  start_position = {
    x = -1516,
    y = 66,
    z = -1211
  }

}
