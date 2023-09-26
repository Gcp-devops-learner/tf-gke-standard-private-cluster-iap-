project_id   = "km1-runcloud"
cluster_name = "gke-terraform-project"
region       = "europe-west2"
network = "gke-network"
subnetwork = "gke-subnet"
ip_range_pods_name = "ip-range-pods"
ip_range_services_name = "ip-range-services"
ip_cidr_range_pods = "10.20.0.0/16"
ip_cidr_range_service = "10.30.0.0/16"



 node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-small"
      node_locations            = "europe-west2-b,europe-west2-c"
      min_count                 = 0
      max_count                 = 0
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      logging_variant           = "DEFAULT"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = "sricharank-km1-runcloud-iam-gs@km1-runcloud.iam.gserviceaccount.com"
      preemptible               = false
      initial_node_count        = 2
    },
  ]
  

 