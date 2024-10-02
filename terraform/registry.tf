resource "yandex_container_registry" "my_registry" {
  name      = "my-registry"
}

resource "yandex_container_registry_iam_binding" "puller" {
  registry_id = yandex_container_registry.my_registry.id
  role        = "container-registry.images.puller"

  members = [
    "system:allUsers",
  ]
}

resource "yandex_container_registry_iam_binding" "pusher" {
  registry_id = yandex_container_registry.my_registry.id
  role        = "container-registry.images.pusher"

  members = [
      "system:allUsers",
  ]
}


resource "null_resource" "docker" {
  # triggers = {
  #   always_run = "${timestamp()}"
  # }
  depends_on = [yandex_container_registry.my_registry]
  
  provisioner "local-exec" {
    command = "docker build . -t cr.yandex/${yandex_container_registry.my_registry.id}/nginx:v1.0.0 -f Dockerfile"
    working_dir = "${path.root}/../docker"
  }  
  
  provisioner "local-exec" {
    command = "docker tag cr.yandex/${yandex_container_registry.my_registry.id}/nginx:v1.0.0 cr.yandex/${yandex_container_registry.my_registry.id}/nginx:latest"
  }  
  
  provisioner "local-exec" {
    command = "docker push cr.yandex/${yandex_container_registry.my_registry.id}/nginx:v1.0.0 && docker push cr.yandex/${yandex_container_registry.my_registry.id}/nginx:latest"
  }  
}
resource "local_file" "registry_id_file" {
  filename = "../ansible/registry_id.txt"
  content  = "my_registry_id: ${yandex_container_registry.my_registry.id}"
}