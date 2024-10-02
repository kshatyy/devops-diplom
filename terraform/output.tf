output "Grafana_address" {
  value = [
    for listener in yandex_lb_network_load_balancer.nlb-grafana.listener :
    [
      for spec in listener.external_address_spec :
      "http://${spec.address}:${listener.port}"
    ][0]
  ][1]
}

output "my_registry_id" {
  value = yandex_container_registry.my_registry.id
  
}

output "K8S_address" {
  value = [
    for listener in yandex_lb_network_load_balancer.nlb-k8s.listener :
    [
      for spec in listener.external_address_spec :
      "${spec.address}:${listener.port}"
    ][0]
  ][0]
}

output "App_address" {
  value = [
    for listener in yandex_lb_network_load_balancer.nlb-grafana.listener :
    [
      for spec in listener.external_address_spec :
      "http://${spec.address}:${listener.port}"
    ][0]
  ][0]
}
