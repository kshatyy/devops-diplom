############ Cloud vars ###############

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}


// --------------------------
// Объявляем зоны
variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
// --------------------------

variable "private_cidr" {
  type        = list(string)
  default     = ["10.10.10.0/24", "10.20.20.0/24", "10.30.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "local-network"
  description = "VPC network name"
}

variable "vms_resources" {
  type = map(object({
      cores=number
      memory=number
      core_fraction=number
 
  }))
  description = "VM Resourses"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform vCPU"
}

variable "metadata_vm" {
  type = map(object({
    serial-port-enable = number
    ssh-keys = string
  }))
 default = {
  metadata = {
    serial-port-enable = 1
    ssh-keys           = ""
  
  }
 }

}

variable "access_key" {
  type        = string
  description = "Access key for Yandex Cloud Storage"
  default     = ""
}

variable "secret_key" {
  type        = string
  description = "Secret key for Yandex Cloud Storage"
  default     = ""
}

variable "account_id" {
  type        = string
  description = "Service account ID"
  default     = ""
}

variable "ssh_pub" {
  type        = string
  description = "Service account ID"
  default     = ""
}
