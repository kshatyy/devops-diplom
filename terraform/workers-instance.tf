resource "yandex_compute_instance" "workers" {
  count = length(local.vpc_zone)
  name  = "worker-${count.index+1}"
  hostname = "worker-${count.index+1}"
  zone     = local.vpc_zone[count.index]
   resources {
   cores=var.vms_resources.workers_vm.cores
   memory=var.vms_resources.workers_vm.memory
   core_fraction=var.vms_resources.workers_vm.core_fraction
  }
  platform_id = var.platform_id
  boot_disk {
    initialize_params {
      image_id = "fd8itdevtr1oqrgeavk3"
      size     = 15
    }
  }
  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet[count.index].id
    nat       = false
  }
  metadata = local.metadata_vm
}