terraform {
  required_providers {
    lambdalabs = {
      source = "elct9620/lambdalabs"
    }
  }
}

# TF_VAR_lambdalabs_api_key
variable "lambdalabs_api_key" {
  type = string
  sensitive = true
}

# TF_VAR_region
variable "region" {
  type = string
}

# TF_VAR_gpu
variable "gpu" {
  type = string
}

provider "lambdalabs" {
  api_key = var.lambdalabs_api_key
}

resource "lambdalabs_instance" "notebook_server" {
  region_name = var.region
  instance_type_name = var.gpu
  ssh_key_names = [
    "lambda_labs"
  ]
}

output "ip" {
  value = lambdalabs_instance.notebook_server.ip
}

output "id" {
  value = lambdalabs_instance.notebook_server.id
}
