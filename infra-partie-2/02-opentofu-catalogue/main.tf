mainterraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "stack_net" {
  name = "opentofu_stack"
}

resource "docker_volume" "pg_data" { name = "pg_data" }
resource "docker_volume" "redis_data" { name = "redis_data" }

resource "docker_container" "postgres" {
  image   = "postgres:16-alpine"
  name    = "postgres"
  restart = "always"

  networks_advanced { name = docker_network.stack_net.name }

  env = [
    "POSTGRES_USER=demo_user",
    "POSTGRES_PASSWORD=demo_pass",
    "POSTGRES_DB=demo_db"
  ]

  volumes {
    volume_name    = docker_volume.pg_data.name
    container_path = "/var/lib/postgresql/data"
  }
}

resource "docker_container" "redis" {
  image   = "redis:7-alpine"
  name    = "redis"
  restart = "always"

  networks_advanced { name = docker_network.stack_net.name }

  env = [
    "REDIS_PASSWORD=demo_pass"
  ]
  command = ["redis-server", "--requirepass", "demo_pass"]

  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }
}

resource "docker_image" "api_image" {
  name = "opentofu-api:latest"
  build {
    context = "./api"
  }
}

resource "docker_container" "api" {
  image = docker_image.api_image.name
  name    = "opentofu-api"
  restart = "always"

  networks_advanced { name = docker_network.stack_net.name }

  depends_on = [
    docker_container.postgres,
    docker_container.redis
  ]

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "API_PORT=3000",
    "POSTGRES_HOST=postgres",
    "POSTGRES_USER=demo_user",
    "POSTGRES_PASSWORD=demo_pass",
    "POSTGRES_DB=demo_db",
    "REDIS_PASSWORD=demo_pass"
  ]
}