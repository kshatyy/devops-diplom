// Creating a bucket using the key
resource "yandex_storage_bucket" "my_bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket                = "kshatyy3"
  #max_size              = 1073741824
  default_storage_class = "STANDARD"
  acl    = "private"
  
}
