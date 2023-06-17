resource "random_string" "random" {
  count = var.count_in
  length   = 4
  special  = false
  upper    = false

  # count   = local.container_count
}

resource "docker_container" "app_container" {
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  count = var.count_in

  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }

  volumes {
    volume_name    = docker_volume.container_volume[count.index].name
    container_path = var.container_path_in
    # host_path      = var.host_path_in
  }
}

resource "docker_volume" "container_volume" {
  name  = "${var.name_in}-${random_string.random[count.index].result}-volume"
  count = var.count_in

  lifecycle {
    prevent_destroy = false
  }

  provisioner "local-exec" {
    when = destroy
    command = "mkdir ${path.cwd}/../backup/"
    on_failure = continue
  }

  provisioner "local-exec" {
    when = destroy
    command = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
    on_failure = fail
    
  }
}