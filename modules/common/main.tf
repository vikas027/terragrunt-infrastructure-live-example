variable "dummy" {
  default = "dummy"
}


resource "null_resource" "dummy" {
  provisioner "local-exec" {
    command = "echo ${var.dummy}"
  }

  triggers = {
    hack = "${timestamp()}"
  }
}
