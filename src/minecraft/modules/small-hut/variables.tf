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

variable "glass_material" {
  description = "Material used for the window (e.g. glass)"
  type        = string
}
