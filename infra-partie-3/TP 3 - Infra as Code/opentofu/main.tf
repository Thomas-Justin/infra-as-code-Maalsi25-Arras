resource "docker_network" "ws_net" {
  name = var.network_name
}

resource "docker_volume" "pg_data" {
  name = "${var.project_name}_pg_data"
}

resource "docker_container" "postgres" {
  name  = "${var.project_name}_postgres"
  image = "postgres:16-alpine"

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}",
  ]

  networks_advanced {
    name = docker_network.ws_net.name
  }

  mounts {
    target = "/var/lib/postgresql/data"
    source = docker_volume.pg_data.name
    type   = "volume"
  }

  ports {
    internal = 5432
    external = var.postgres_port
  }
}

resource "docker_image" "api" {
  name = "${var.project_name}_api:latest"

  build {
    context = "${path.module}/app"
  }
}

resource "docker_container" "api" {
  name  = "${var.project_name}_api"
  image = docker_image.api.image_id

  networks_advanced {
    name = docker_network.ws_net.name
  }

  env = [
    "PORT=3000",
    "PGHOST=${docker_container.postgres.name}",
    "PGPORT=5432",
    "PGUSER=${var.postgres_user}",
    "PGPASSWORD=${var.postgres_password}",
    "PGDATABASE=${var.postgres_db}",
  ]

  depends_on = [docker_container.postgres]
}

resource "docker_image" "nginx" {
  name = "${var.project_name}_nginx:latest"

  build {
    context = "${path.module}/nginx"
  }
}

resource "docker_container" "nginx" {
  name  = "${var.project_name}_nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.ws_net.name
  }

  ports {
    internal = 80
    external = var.nginx_port
  }

  depends_on = [docker_container.api]
}