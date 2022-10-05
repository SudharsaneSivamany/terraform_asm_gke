project_id = "my-project"

gke_cluster = {
  name   = "gke-private-cluster"
  region = "us-central1"
  zones  = ["us-central1-c"]
  vpc = {
    vpc_name    = "vpc-gke-1"
    vpc_subnet  = "central-4"
    vpc_sec_pod = "pod-range"
    vpc_sec_svc = "service-range"
  }
  master_ipv4_cidr_block = "<0.0.0.0>/28"
  master_authorized_networks = [{
    cidr_block   = "<cloudshellip>/32"
    display_name = "cloudshell"
  }]
  node_pool = [{
    name               = "default-node-pool"
    machine_type       = "e2-standard-4"
    node_locations     = "us-central1-c"
    autoscaling        = true
    auto_upgrade       = true
    initial_node_count = 3
  }, ]
}

router = {
  name     = "nat-router-tf"
  nat_name = "nat-config-tf"
  network  = "vpc-gke-1"
  region   = "us-central1"
}
