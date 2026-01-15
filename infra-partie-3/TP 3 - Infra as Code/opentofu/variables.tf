variable "project_name" {
  description = "Préfixe des ressources Docker"
  type        = string
  default     = "ws"
}

variable "network_name" {
  description = "Nom du réseau Docker dédié"
  type        = string
  default     = "ws-net"
}

variable "nginx_port" {
  description = "Port hôte pour accéder au reverse proxy Nginx"
  type        = number
  default     = 8080
}

variable "postgres_port" {
  description = "Port hôte Postgres (optionnel, utile si tu veux te connecter depuis un client local)"
  type        = number
  default     = 5432
}

variable "postgres_user" {
  type    = string
  default = "ws"
}

variable "postgres_password" {
  type    = string
  default = "ws"
}

variable "postgres_db" {
  type    = string
  default = "ws"
}