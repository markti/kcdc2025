variable "start_position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "material" {
  description = "Material used for the frame (e.g. dirt)"
  type        = string
}

variable "door_material" {
  description = "Material used for the window (e.g. glass)"
  type        = string
}

variable "direction" {
  type        = string
  description = "Direction of wall: 'east' (along x) or 'north' (along z)"
  default     = "east"
}
