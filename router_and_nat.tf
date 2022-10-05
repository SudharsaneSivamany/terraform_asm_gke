module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  name    = var.router.name
  project = var.project_id
  region  = var.router.region
  network = var.router.network
}

module "cloud-nat" {
  depends_on                         = [module.cloud_router]
  source                             = "terraform-google-modules/cloud-nat/google"
  project_id                         = var.project_id
  region                             = var.router.region
  router                             = var.router.name
  name                               = var.router.nat_name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
