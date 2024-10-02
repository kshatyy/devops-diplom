# Создаю группу балансировщика
resource "yandex_lb_target_group" "nlb-group" {
  name       = "nlb-group"
  depends_on = [yandex_compute_instance.workers]
  dynamic "target" {
    for_each = yandex_compute_instance.workers
    content { 
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

# Создаю балансировщик grafana и app
resource "yandex_lb_network_load_balancer" "nlb-grafana" {
  name = "nlb-grafana"
  listener {
    name        = "grafana-listener"
    port        = 3000
    target_port = 31000
    external_address_spec {
      ip_version = "ipv4"
    }
  }

    listener {
    name        = "app-listener"
    port        = 80
    target_port = 31080
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.nlb-group.id
    healthcheck {
      name = "healthcheck-grafana"
      tcp_options {
        port = 31000
      }
    }
  }
  depends_on = [yandex_lb_target_group.nlb-group]
}

# Создаю группу балансировщика для kubectl
resource "yandex_lb_target_group" "nlb-k8s" {
  name       = "nlb-k8s"
  target {
    subnet_id  = yandex_compute_instance.masters.network_interface.0.subnet_id
    address    = yandex_compute_instance.masters.network_interface.0.ip_address
  }
}
  

# Создаю балансировщик k8s
resource "yandex_lb_network_load_balancer" "nlb-k8s" {
  name = "nlb-k8s"
  listener {
    name        = "k8s-listener"
    port        = 16443
    target_port = 6443
    external_address_spec {
      ip_version = "ipv4"
    }
  }


  attached_target_group {
    target_group_id = yandex_lb_target_group.nlb-k8s.id
    healthcheck {
      name = "healthcheck-k8s"
      tcp_options {
        port = 6443
      }
    }
  }
  depends_on = [yandex_lb_target_group.nlb-k8s]
}


