

module "kcdc_pyramid" {

  count = 1

  source = "./modules/pyramid"

  material = "minecraft:gold_block"

  start_position = {
    x = -1505,
    y = 62,
    z = -1151
  }
  length = 20

}

