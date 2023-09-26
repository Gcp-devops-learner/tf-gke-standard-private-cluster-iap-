### Common variables

variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}
variable "region" {
  type        = string
  description = "The region to host the cluster in"
}

variable "node_pools" {
  type = list(map(string))

}


variable "env_name" {
  type        = string
  description = "The environment for the GKE cluster"
  default     = "dev"
}

variable "bastion_members" {
  type        = list(string)
  description = "List of users, groups, SAs who need access to the bastion host"
  default     = []
}

### Cluster variables
variable "cluster_name" {
  type        = string
  description = "The name for the GKE cluster"
  default     = ""
}
variable "network" {
  type        = string
  description = "The VPC network created to host the cluster in"
  default     = ""
}
variable "subnetwork" {
  type        = string
  description = "The subnetwork created to host the cluster in"
  default     = ""
}
variable "ip_range_pods_name" {
  type        = string
  description = "The secondary ip range to use for pods"
  default     = ""
}
variable "ip_range_services_name" {
  type        = string
  description = "The secondary ip range to use for services"
  default     = ""
}

 variable "ip_cidr_range_pods" {
  type = string
  description = "Ip range pods should be mentioned"
 }

 variable "ip_cidr_range_service" {
  type = string
  description = "Ip range service should be mentioned"
 }


variable "zones" {
  type        = list(string)
  description = "The project ID to host the cluster in"
  default     = ["europe-west2-a", "europe-west2-b"]
}

