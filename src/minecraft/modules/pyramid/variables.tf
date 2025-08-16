variable "material" {
  type = string
}

variable "start_position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "length" {
  type = number
}
