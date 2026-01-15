output "urls" {
  value = {
    app_via_nginx = "http://localhost:${var.nginx_port}"
    postgres      = "localhost:${var.postgres_port}"
  }
}