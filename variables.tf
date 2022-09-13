variable "env"{
  type = string
  default= "dev"
}
 variable "image"{

  type = map
  description = "image for conatainer"
  default= {
    dev ="nodered/node-red:latest"
    prod ="nodered/node-red:latest-minimal"
  }
 }





variable "ext_port" {
  type = map

  sensitive = true
  validation{
    condition = max(var.ext_port["prod"]...) <= 65535 && min(var.ext_port["prod"]...) >= 1980
    error_message ="External port must be in between 0 and 65535."
   }
   validation{
    condition = max(var.ext_port["dev"]...) < 1980 && min(var.ext_port["dev"]...) >= 1880
    error_message ="External port must be in between 0 and 65535."
   }
}

variable "int_port" {
  type = number
  sensitive = true
  validation{
    condition = var.int_port == 1880
    error_message = "Internal port must be 1880."
  }
}

locals {
  container_count = length(lookup(var.ext_port,terraform.workspace))
}
