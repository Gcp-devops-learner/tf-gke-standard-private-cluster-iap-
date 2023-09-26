module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "6.0.0"
  project_id   = var.project_id
  network_name = "${var.network}-${var.env_name}"

  subnets = [
    {
      subnet_name   = "${var.subnetwork}-${var.env_name}"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
    },
  ]

  secondary_ranges = {
    "${var.subnetwork}-${var.env_name}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range =  var.ip_cidr_range_pods              
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = var.ip_cidr_range_service                                    
      },
    ]
  }
}

module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "~> 4.0"
  project_id    = var.project_id
  region        = var.region
  router        = "safer-router"
  network       = module.gcp-network.network_self_link
  create_router = true
}