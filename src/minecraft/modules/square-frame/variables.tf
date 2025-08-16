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
variable "length" {
  type = number
}
