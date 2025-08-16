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

variable "arch_length" {
  type    = number
  default = 10
  validation {
    condition     = var.arch_length >= 6 && var.arch_length % 2 == 0
    error_message = "Length must be even and >= 6."
  }
}

variable "arch_count" {
  description = "Number of arches in the wall"
  type        = number
}

variable "direction" {
  type        = string
  description = "Direction of wall: 'east' (along x) or 'north' (along z)"
  default     = "east"
}
