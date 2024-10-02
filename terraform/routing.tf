resource "yandex_vpc_route_table" "netology-routing" {
  name       = "netology-routing"
  network_id = yandex_vpc_network.network_vpc.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.1.254"
  }
}