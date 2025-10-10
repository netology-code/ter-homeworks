module "vpc_develop" {
  network_name = "dev-network"
  subnet_name  = "dev-subnet"
  source       = "./modules/vpc"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}