resource "yandex_compute_instance" "masters" {
  name  = "master-1"
  hostname = "master-1"
  zone     = local.vpc_zone[0]
   resources {
   cores=var.vms_resources.masters_vm.cores
   memory=var.vms_resources.masters_vm.memory
   core_fraction=var.vms_resources.masters_vm.core_fraction
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
    subnet_id = yandex_vpc_subnet.private_subnet[0].id
    nat       = false
    
  }
  metadata = local.metadata_vm
}