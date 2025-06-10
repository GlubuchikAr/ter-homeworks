variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "subnets" {
  type        = list(
    object({
        cidr: string,
        zone: string,
    })
)
  default     = [
    { 
    zone = "ru-central1-a", 
    cidr = "10.0.1.0/24" 
    },
  ]
  description = "subnets"
}