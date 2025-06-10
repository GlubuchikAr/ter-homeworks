variable "cluster_name" {
  type        = string
  description = "имя_кластера"
}

variable "environment" {
  type        = string
  default     = "PRODUCTION"
  description = "Среда выполнения (PRODUCTION/PRESTABLE)"
}

variable "network_id" {
  type        = string
  description = "идентификатор_сети"
}

variable "mysql_version" {
  type        = string
  default     = "8.0"
  description = "Версия MySQL"
}

variable "mysql_version" {
  type        = string
  default     = "8.0"
  description = "Версия MySQL"
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "защита_кластера_от_удаления"
}

variable "resource_preset_id" {
  type        = string
  default     = "s2.micro"
  description = "класс_хоста"
}

variable "disk_type" {
  type        = string
  default     = "network-hdd"
  description = "тип_диска"
}

variable "disk_size" {
  type        = number
  default     = 10
  description = "Размер диска (ГБ)"
}


variable "subnets" {
  type        = list(string)
  default     = ["10.0.4.0/24"]
  description = "Подсети для хостов"
}

variable "zones" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b"]
  description = "Зоны доступности для хостов"
}

variable "db_name" {
  type        = string
  default     = "default_db"
  description = "Имя создаваемой БД"
}

variable "db_user" {
  type        = string
  default     = "admin"
  description = "Имя администратора"
}

variable "db_password" {
  type        = string
  default     = null
  description = "Пароль администратора"
}

variable "ha" {
  type        = bool
  default     = false
  description = "Включить режим High Availability (2 хоста)"
}

variable "assign_public" {
  type        = bool
  default     = false
  description = "Включить внешний ip"
}