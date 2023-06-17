variable "image" {
  type        = map(any)
  description = "image for container"

  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }
}

variable "ext_port" {
  type = map(any)

  # validation {
  #   condition     = 1980 <= min(var.ext_port["dev"]...) && max(var.ext_port["dev"]...) <= 65535
  #   error_message = "The value of external port must be between 0 and 65535."
  # }

  # validation {
  #   condition     = 1880 <= min(var.ext_port["prod"]...) && max(var.ext_port["prod"]...) < 1980
  #   error_message = "The value of external port must be between 1880 and 1980."
  # }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The value of internal port must be 1880."
  }

}

# locals {
#   container_count = length(var.ext_port["nodered"][terraform.workspace])
# }