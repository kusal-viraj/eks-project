variable "availability_zone" {
  description = "Availability zone for the EBS volume."
  type        = string
}

variable "volume_size" {
  description = "Size of the volume in GB."
  type        = number
  default     = 10
}

variable "volume_type" {
  description = "The type of EBS volume."
  type        = string
  default     = "gp2"
}

variable "volume_name" {
  description = "The name of the EBS volume."
  type        = string
}
