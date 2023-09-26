/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

 data "template_file" "startup_script" {
  template = <<-EOF
  sudo apt-get update -y
  sudo apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin
  sudo apt-get install -y kubectl
  sudo apt-get install -y tinyproxy
  EOF
}

locals {
  bastion_name = format("%s-bastion", var.cluster_name)
  bastion_zone = format("%s-a", var.region)
}

module "bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 5.0"

  network        = module.gcp-network.network_self_link
  subnet         = module.gcp-network.subnets_self_links[0]
  project        = var.project_id
  host_project   = var.project_id
  name           = local.bastion_name
  zone           = local.bastion_zone
  image_project  = "debian-cloud"
  machine_type   = "e2-small"
  startup_script = data.template_file.startup_script.rendered
  members        = var.bastion_members
  shielded_vm    = "false"
}

module "member_roles" {
  source = "terraform-google-modules/iam/google//modules/member_iam"
  service_account_address = "bastion@km1-runcloud.iam.gserviceaccount.com"
  prefix = "serviceAccount"
  project_id = var.project_id
  project_roles = ["roles/container.admin", "roles/container.clusterAdmin", "roles/container.hostServiceAgentUser"]
}