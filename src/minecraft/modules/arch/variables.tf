variable "start_position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "length" {
  type    = number
  default = 10
  validation {
    condition     = var.length >= 6 && var.length % 2 == 0
    error_message = "Length must be even and >= 6."
  }
}

variable "material" {
  type = string
}

variable "direction" {
  type        = string
  description = "Direction of wall: 'east' (along x) or 'north' (along z)"
  default     = "east"
}
