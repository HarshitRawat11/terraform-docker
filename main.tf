module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image

}

module "container" {
  source            = "./container"
  for_each          = local.deployment
  name_in           = each.key
  count_in          = each.value.container_count
  image_in          = module.image[each.key].image_out
  int_port_in       = each.value.int
  ext_port_in       = each.value.ext
  container_path_in = each.value.container_path

  # name_in           = join("-", [each.key, terraform.workspace, random_string.random[each.key].result])
  # ext_port_in       = var.ext_port[terraform.workspace][count.index]
  # host_path_in      = "${path.cwd}/noderedvol"
  # depends_on        = [null_resource.dockervol]
  # count             = local.container_count
}


# resource "null_resource" "dockervol" {
#   provisioner "local-exec" {
#     command = "mkdir noderedvol/ || true && chown -R 1000:1000 noderedvol/"
#   }
# }