###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCf+mkgGwx3KKMFm5TYSYa/2Y1vciycnp4Oc6yBUOMP/Ykm7VHpSTqnUlYIrXqKEoWxla45xPcZBSFdyRvA95EGgHpbh3B5mszmcH+8OSBeAQtkk6A6tLEAhRMShNwHTp65tAXGxtKW0gNlHzne/+5fCnI4UYK1Ig+cC8bOhLbnNEQKMYzNvSwHarQC3buCLKgW/S0GGjVqfjX9ho0FoZhuh2wB9cF5sB8sKBKn8KQ12IEHZyPzqas2SnuBWHAkOqlkprBRp5WxZhs7cLUjfnd4qtlKCp5J+agCKHamn7h2tFTNwNMGd9EJfIPlE54vjz0tI9UD8nKrMUx6R95RC8jlK3nSv1akhwRN4o3soWHrGQgiqpI2Z145bj38Hg8KCEzDNr5H2iKWoCOTRAGb3odIysENMqUQtbk6jql7gJqd6tLgA8VOg75B/fFFLpGCVjhy5rCYXWwAU1h/X2EjxQlAeE789sW2bHisiRzG9loGNWFTuH2rWdakHxH9Tg5dbTE= glubuchik@glubuchik-pc"
  description = "ssh-keygen -t ed25519"
}
