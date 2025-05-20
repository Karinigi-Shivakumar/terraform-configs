module "network" {
  source     = "./modules/network"
  project_id = var.project_id
}

module "compute" {
  source            = "./modules/compute"
  project_id        = var.project_id
  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
}

module "firewall" {
  source     = "./modules/firewall"
  project_id = var.project_id
  vpc_id     = module.network.vpc_id
}

