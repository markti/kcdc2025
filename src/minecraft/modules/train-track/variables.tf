variable "start_position" {
  type = object({
    x = number
    y = number
    z = number
  })
  description = "The start coordinate of the platform (bottom-left corner)"
}

variable "length" {
  type        = number
  description = "The number of blocks long the train track platform should be"
}

variable "direction" {
  type        = string
  default     = "east"
  description = "Direction the track runs: 'east' (x-axis) or 'north' (z-axis)"
  validation {
    condition     = contains(["east", "north"], var.direction)
    error_message = "Direction must be 'east' or 'north'"
  }
}

variable "platform_material" {
  type        = string
  default     = "minecraft:stone"
  description = "Block used for the platform"
}

variable "track_material" {
  type        = string
  default     = "minecraft:powered_rail"
  description = "Block type for the track"
}

variable "redstone_torch_gap" {
  type        = number
  default     = 7
  description = "Gap between redstone torches along the track"
}
