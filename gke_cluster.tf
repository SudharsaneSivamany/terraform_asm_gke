# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_project" "project" {
  project_id = var.project_id
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = var.gke_cluster.name
  region                     = var.gke_cluster.region
  zones                      = var.gke_cluster.zones
  network                    = var.gke_cluster.vpc.vpc_name
  subnetwork                 = var.gke_cluster.vpc.vpc_subnet
  ip_range_pods              = var.gke_cluster.vpc.vpc_sec_pod
  ip_range_services          = var.gke_cluster.vpc.vpc_sec_svc
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = var.gke_cluster.master_ipv4_cidr_block
  remove_default_node_pool   = true
  cluster_resource_labels    = { "mesh_id" : "proj-${data.google_project.project.number}" }
  create_service_account     = false

  master_authorized_networks = var.gke_cluster.master_authorized_networks

  node_pools = var.gke_cluster.node_pool

}

module "asm" {
  module_depends_on         = [module.gke]
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  project_id                = var.project_id
  cluster_name              = module.gke.name
  cluster_location          = module.gke.location
  enable_cni                = true
  enable_fleet_registration = true
}


