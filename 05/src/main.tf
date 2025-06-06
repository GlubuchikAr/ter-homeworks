module "vpc"{
  source   = "./vpc"
  vpc_name = "develop"
  zone     = "ru-central1-a"
  cidr     = ["10.0.1.0/24"]
}


module "marketing" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc.network[0].id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc.subnet[0].id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "i.ivanov",
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}
module "analytics" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc.network[0].id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc.subnet[0].id]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "i.ivanov",
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = file("~/.ssh/aglubuchik.pub")
  }
}



# Задание 4
# module "vpc_prod" {
#   source       = "./vpc"
#   vpc_name     = "production"
#   subnets = [
#     { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
#     { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
#     { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
#   ]
# }
# module "vpc_dev" {
#   source       = "./vpc"
#   vpc_name     = "develop"
#   subnets = [
#     { zone = "ru-central1-a", cidr = "10.0.4.0/24" },
#   ]
# }