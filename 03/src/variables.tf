###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
  description = "VPC network&subnet name"
}

variable "vm_family" {
  type        = string
  description = "image_family"
  default     = "ubuntu-2004-lts"
}

variable "vm_platform_id" {
  type        = string
  description = "instance_platform_id"
  default     = "standard-v1"
}

variable "instance_resources" {
  type        = map(object({
    cores               = number,
    memory              = number,
    core_fraction       = number,
    disk_type           = string,
    disk_size           = number,
    preemptible         = bool,
    nat                 = bool,
    serial-port-enable  = number
    }))
  default     = {default = {
      cores              = 2
      memory             = 1
      core_fraction      = 5
      disk_type          = "network-hdd"
      disk_size          = 10
      preemptible        = true
      nat                = true
      serial-port-enable = 1
    }}
  description = "instance_resources"
}


variable "each_vm" {
  type        = list(object({
    vm_name             = string,
    cores               = number,
    memory              = number,
    core_fraction       = number,
    disk_type           = string,
    disk_size           = number,
    preemptible         = bool,
    nat                 = bool,
    serial-port-enable  = number
    }))
  description = "DB VM"
  default     = [
    {
      vm_name       = "main"
      cores         = 2
      memory        = 2
      core_fraction = 5
      disk_type     = "network-hdd"
      disk_size     = 11
      preemptible   = true
      nat           = true
      serial-port-enable = 1
    },
    {
      vm_name            = "replica"
      cores              = 2
      memory             = 1
      core_fraction      = 5
      disk_type          = "network-hdd"
      disk_size          = 10
      preemptible        = true
      nat                = true
      serial-port-enable = 1
    }]
}