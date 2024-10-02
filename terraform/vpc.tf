resource "yandex_vpc_network" "network_vpc" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "private_subnet" {
  count          = length(local.vpc_zone)
  name           = "private_${local.vpc_zone[count.index]}"
  zone           = local.vpc_zone[count.index]
  network_id     = yandex_vpc_network.network_vpc.id
  v4_cidr_blocks = [var.private_cidr[count.index]]
  route_table_id = yandex_vpc_route_table.netology-routing.id
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public_${local.vpc_zone[0]}"
  zone           = local.vpc_zone[0]
  network_id     = yandex_vpc_network.network_vpc.id
  v4_cidr_blocks = var.public_cidr
}
