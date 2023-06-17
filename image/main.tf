resource "docker_image" "container_image" {
  #   name = lookup(var.image, terraform.workspace)
  name = var.image_in
}