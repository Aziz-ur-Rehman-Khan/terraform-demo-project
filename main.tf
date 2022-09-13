
resource "null_resource""docker_vol"{
  provisioner "local-exec" {
  command = "mkdir nodered_vol/ || true && sudo chown -R 1000:1000 nodered_vol/"
  }
  }
module "image" {
  source = "./image"
  image_in = var.image[terraform.workspace]
}
module "container" {
  source = "./container"
  depends_on = [null_resource.docker_vol]

  count = local.container_count
  image_in = module.image.image_out
  name_in  = join("-",["nodered",terraform.workspace,random_string.random[count.index].result])
  int_port_in= var.int_port
  ext_port_in= var.ext_port[terraform.workspace][count.index]
  container_path_in="/data"
  host_path_in = "${path.cwd}/nodered_vol"
}
resource "random_string" "random" {
  count = local.container_count
  length = 4
  special = false
  upper = false
}
