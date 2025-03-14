terraform {
  required_providers {
    lambdalabs = {
      source = "elct9620/lambdalabs"
    }
  }
}

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

resource "lambdalabs_instance" "deepseek_r1" {
  region_name = var.region
  instance_type_name = var.gpu
  ssh_key_names = [
    "lambda_labs"
  ]
  /*
  file_system_names = [
    "deepseek-r1-${var.region}"
  ]
  */
}

output "ip" {
  value = lambdalabs_instance.deepseek_r1.ip
}

output "id" {
  value = lambdalabs_instance.deepseek_r1.id
}
