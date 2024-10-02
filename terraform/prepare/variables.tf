############ Cloud vars ###############
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

variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


variable "access_key" {
  description = "Access key for Yandex Cloud Storage"
  default     = ""  # Можно оставить пустым
}

variable "secret_key" {
  description = "Secret key for Yandex Cloud Storage"
  default     = ""  # Можно оставить пустым
}
