
# YC

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}
variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

# YC zones

variable "default_region" {
  type        = string
  default     = "ru-central1"
}
variable "vms_zone" {
  type        = string
  default     = "standard-v3"
}
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

# VPC

variable "network_name" {
  type = string
  default = "network"
}
variable "subnets" {
   type = map(any)
   default = {
      sub-a = {
         name = "public-a"
         zone = "ru-central1-a"
         cidr = "10.0.1.0/24"
      }
      sub-b = {
         name = "public-b"
         zone = "ru-central1-b"
         cidr = "10.0.2.0/24"
      }
      sub-d = {
         name = "public-d"
         zone = "ru-central1-d"
         cidr = "10.0.3.0/24"
      }
   }
}

# VM Images

variable "family_vm_ig" {
  type        = string
  default     = "lemp"
  description = "yandex_compute_image_family_ig"
}

# VM

variable "vms" {
  type = list(object({ 
    name = string,
    platform_id = string, 
    cpu        = number, 
    ram        = number, 
    disk       = number,
    cf         = number,
    type       = string
    }))
  default = [ 
    {
    name        = "ig-1"
    platform_id = "standard-v3"
    cpu         = 2
    ram         = 2
    disk        = 10
    cf          = 20
    type        = "network-ssd"
    }
  ]
  description = "vms resources"
}