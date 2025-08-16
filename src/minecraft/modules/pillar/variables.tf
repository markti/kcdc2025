variable "material" {
  description = "The block material to use (e.g. minecraft:dirt)"
  type        = string
}

variable "start_position" {
  description = "The starting x, y, z position of the pillar"
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "length" {
  description = "The number of blocks tall the pillar should be"
  type        = number
}

variable "direction" {
  type        = string
  description = "Direction to build: N, S, E, W, UP, DOWN"
  validation {
    condition     = contains(["N", "S", "E", "W", "UP", "DOWN"], var.direction)
    error_message = "Must be one of: N, S, E, W, UP, DOWN"
  }
  default = "UP"
}